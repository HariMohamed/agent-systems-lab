# V2 Persistent State & State Ownership

## State Model Overview
The evaluation architecture now implements an explicit state abstraction `StateStore` to model the lifecycle, ownership, and boundaries of data persisted across agent sessions. State is intentionally modeled strictly as **DATA**, ensuring it never implicitly becomes **AUTHORITY**.

## Ownership & Isolation Rules
State records (`StateRecord`) are cryptographically bound to a specific `owner_actor_id`.
1. **Explicit Identity:** Anonymous or global state mutation is strictly forbidden.
2. **Actor Isolation:** Sibling agents cannot access or overwrite each other's state.
3. **Immutability:** Core identity fields (`state_id`, `owner_actor_id`, `task_id`) are structurally immutable and cannot be rewritten via payload injection.

## Concurrency & Versioning
State modifications utilize **Optimistic Concurrency**. Every update explicitly requires an expected version number. If a stale update is detected (`writer B` attempts to save over `version 1` when `version 2` exists), the engine halts the write and responds with `VERSION_CONFLICT`, eliminating silent lost updates.

## Bounded Limits
State is strictly bounded to prevent unconstrained memory exploitation or infinite loop data growth:
- `max_state_records`
- `max_payload_bytes`
- `max_versions`
- `max_updates_per_task`

## Secret Sanitization
Before any state reaches persistence or trace evaluation, a recursive deterministic sanitizer sweeps the dictionary payload. Any string containing keys or values implying secrets is deterministically overwritten with `[REDACTED]`. State records strictly trace reasoning logic, never cryptographic credentials.

## Lifecycle Semantics
Valid state transitions explicitly map to:
- `CREATED`, `ACTIVE`, `PAUSED`, `COMPLETED`, `FAILED`, `CANCELLED`, `EXPIRED`, `UNKNOWN`

## Recovery & Ambiguity
If execution ambiguity arises (e.g. timeout on an orchestrated task), the system explicitly records `UNKNOWN`. It does NOT blindly retry mutation without passing through the `IdempotencyEngine`, nor does it assume `SUCCESS`.

## Deletion
To preserve audit integrity, deletions are soft-handled (Tombstoned). Invoking `delete()` transitions the `StateRecord` to `CANCELLED`, ensuring the audit trace graph remains intact for security verification.
