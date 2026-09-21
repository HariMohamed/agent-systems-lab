# V2 Persistent State & State Ownership Report

## Scope
This phase introduces a deterministic, isolated Persistent State layer to the V2 evaluation architecture. The core objective is establishing rigorous data boundaries—ownership, optimistic concurrency, and strict limits—before semantic memory capabilities are introduced.

## State Model
The `StateStore` implements deterministic state abstraction. State records contain metadata (`state_id`, `version`, `status`, `owner`, `task`) and a JSON `payload`. Crucially, state is mathematically defined strictly as **DATA**. It cannot mutate authority, capabilities, or execution identities.

## Ownership Model
Anonymous state mutation is blocked. Every `StateRecord` explicitly belongs to an `owner_actor_id`. State identity metadata is completely immutable—no JSON payload updates can arbitrarily rewrite the owner field.

## Access Control
The `StateStore` strictly isolates cross-actor state. An agent, even if it is a supervisor, cannot read, update, or tombstone a sibling or child agent's state without explicit policy authorization.

## Versioning & Concurrency
State mutations use strict Optimistic Concurrency. Any state update must explicitly declare the expected version sequence. Stale writes deterministically return `VERSION_CONFLICT` rather than silently overwriting another concurrent task's updates, completely neutralizing lost-update vulnerabilities.

## Recovery & Idempotency
Because the `StateStore` integrates into the pipeline downstream from Authorization and Execution deduplication, ambiguous outcomes properly map to `UNKNOWN`. The state machine requires explicit transition resolution; it does not blindly retry writes or assume success on absent failures.

## Multi-Agent Isolation
Delegations pass context, but they do NOT implicitly pass unrestricted global state. An agent cannot access its parent's orchestration state.

## Security Properties
- **Secret Redaction:** Any string or key containing "secret" is deterministically scrubbed via recursive sanitization before persistence (`[REDACTED]`).
- **Resource Limits:** `max_records`, `max_payload_bytes`, and `max_versions` are explicitly enforced.
- **Tombstone Semantics:** Auditable records are soft-deleted (`CANCELLED`) rather than physically erased.

## Tests
The deterministic suite added 13 exhaustive `TestPersistentState` assertions verifying limits, access boundaries, redaction, immutable identities, and concurrency conflicts. All 64 deterministic tests currently PASS.

## Verified Guarantees
- State ownership is explicit.
- Actors cannot access unauthorized state.
- Sibling state is isolated.
- Identity fields cannot be rewritten.
- Lost updates and stale writes are prevented (Concurrency).
- Secrets are not persisted.
- State payload cannot modify security authority or execution registries.

## Unverified Guarantees
- Distributed physical state persistence (e.g., PostgreSQL, Redis) is `NOT VERIFIED`. The current architecture implements these strict deterministic bounds in-memory for evaluation.

## Residual Risks
- Total process crash still loses in-memory data until a durable backend maps to the `StateStore` interface.

## Release Decision
**RELEASE WITH CONDITIONS**

Deterministic state ownership, isolation, versioning, and recovery semantics are verified within the in-memory evaluation architecture. Physical external storage mappings and Docker containment remain officially unresolved.
