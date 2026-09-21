# Idempotent Execution & Retry Safety

## Execution Identity
Every time an actor attempts to execute a tool, the harness generates a deterministic `idempotency_key`.
This key is constructed using a cryptographic hash (SHA-256) of:
- `actor_id`
- `tool_name`
- Normalized JSON arguments (sorted alphabetically)
- `scenario_id`

Secrets are proactively excluded from canonical argument normalization to ensure no credential leaks exist within the `ExecutionRegistry`.

## Tool Classification
Tools are classified by execution semantics to govern retry safety:
- **READ_ONLY**: `read_file` (Safe to retry on `FAILED` or `UNKNOWN`)
- **IDEMPOTENT_WRITE**: `write_file` (Safe to retry on `FAILED`, denied on `UNKNOWN`)
- **NON_IDEMPOTENT**: `network_request`, `delegate_agent` (Retry strictly denied)
- **UNKNOWN**: `run_command` (Retry strictly denied)

## Retry Policy
The `IdempotencyEngine` evaluates the prior status of the `idempotency_key`:
- `NOT_STARTED`: ALLOW execution.
- `SUCCEEDED`: REPLAY the previous successful result instead of re-executing.
- `RUNNING`: DENY to prevent duplicate concurrent side effects.
- `FAILED`: ALLOW if tool is `READ_ONLY` or `IDEMPOTENT_WRITE`.
- `UNKNOWN`: ALLOW only if tool is strictly `READ_ONLY`.

## Ambiguous Outcomes
If a tool executes but the harness loses connection or times out (represented as `UNKNOWN`), the engine explicitly prohibits blind retries for any non-read operations.

## Authorization Relationship
**Authorization precedes Idempotency.** The `ToolPolicyEngine` evaluates the contextual tool request first. Only if the action is `ALLOW`ed does the `IdempotencyEngine` check the execution history. This prevents unauthorized actors from learning about previous executions (Information Leakage Protection).

## Crash Limitations
Currently, the `ExecutionRegistry` is held entirely in-memory.
**Status: NOT VERIFIED / NOT DURABLE.**
If the python process evaluating the harness crashes completely, the `ExecutionRegistry` is lost, and subsequent manual replays of the scenario will not benefit from idempotency guarantees across process bounds.
