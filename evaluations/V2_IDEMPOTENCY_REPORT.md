# V2 Idempotent Execution Report

## Scope
This phase addresses execution correctness and retry safety within the V2 evaluation harness. The primary objective is to prevent accidental duplicate side effects during retries, model hallucinations, or provider timeouts by strictly classifying tools and tracking deterministic execution identities.

## Execution Model
We introduced an `ExecutionRegistry` that explicitly records the state of execution across the lifecycle (`NOT_STARTED`, `RUNNING`, `SUCCEEDED`, `FAILED`, `UNKNOWN`). This state machine is updated by the harness immediately before and after the physical execution of a tool.

## Idempotency Model
Execution instances are uniquely identified by a deterministic `idempotency_key` constructed by hashing the `actor_id`, `tool_name`, normalized/alphabetized JSON arguments, and `scenario_id`. Secrets are proactively excluded from canonical argument normalization to prevent cryptographic leakage.

## Retry Semantics
Tools are explicitly classified to govern safe retry behavior:
- `READ_ONLY` (`read_file`): Safe to retry unconditionally.
- `IDEMPOTENT_WRITE` (`write_file`): Safe to retry on failure, but denied on ambiguous (`UNKNOWN`) outcomes.
- `NON_IDEMPOTENT` (`network_request`, `delegate_agent`): Retry explicitly denied.
- `UNKNOWN` (`run_command`): Strictly denied.

## Ambiguous Outcomes
In situations where a tool executes but the agent loses connection (the `UNKNOWN` state), the Idempotency Engine strictly prohibits automatic retries for any non-read operations, ensuring no duplicate side effects occur during network drops.

## Security Properties
1. **Authorization Precedes Idempotency:** The Idempotency Engine operates strictly *after* the `ToolPolicyEngine` grants a capability. This ensures unauthorized actors cannot query the execution registry for side channels.
2. **Execution Isolation:** State lookups in the registry enforce an `actor_id` boundary.
3. **No Automatic Retry Explosion:** Loop repetitions of non-idempotent failed requests strictly evaluate to `DENY`.

## Tests
Added `TestIdempotency` to the `test_harness.py` suite. All 15 specific security properties were tested successfully, including key canonicalization, argument shuffling, secret exclusion, retry logic paths, and cross-actor information leakage protection.
The harness test suite (35 tests total) is fully green.

## Verified Guarantees
- Idempotency key generation is deterministic and structurally safe.
- Non-idempotent tool retries are provably denied.
- Secrets are excluded from the hashing context.
- Duplicate successful events successfully replay their previous result without executing twice.

## Unverified Guarantees
- **Durable Crash Recovery:** The `ExecutionRegistry` is currently held in volatile process memory. If the Python execution process crashes entirely, the registry drops, meaning true long-term durability is `NOT VERIFIED`.

## Residual Risks
- Without durable state (e.g., SQLite or Postgres), catastrophic host-level failures will require manual, non-idempotent replays.

## Release Decision
**RELEASE WITH CONDITIONS**

The execution correctness boundaries are fully verified deterministically, but conditions remain regarding the unverified physical Docker sandbox boundary and lack of durable crash storage.
