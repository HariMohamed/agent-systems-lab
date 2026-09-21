# Human-in-the-Loop (HITL) Approval Control Plane

## Architecture Overview
The Approval Control Plane implements a strict separation of concerns, ensuring that explicit human authorization is gathered before executing privileged operations.
It operates strictly AFTER contextual authorization (`ToolPolicyEngine`) and execution deduplication (`IdempotencyEngine`).

## Approval Identity
Approval incorporates a distinct human identity (`approver_id`), structurally isolated from the model's actor identity (`actor_id`).
**Self-approval is hard-blocked**: The model can NEVER authorize its own execution. Any attempt to use the model's identity for the `approver_id` results in a direct policy `DENY`.

## Risk Classification Model
Tools are evaluated to determine if they require human approval based on side-effect semantics and capability risks:
- `LOW`: `read_file` -> `NOT_REQUIRED`
- `MEDIUM`: `write_file`, `delegate_agent` -> `NOT_REQUIRED`
- `HIGH`: `network_request` -> `REQUIRED`
- `CRITICAL`: `run_command` -> `REQUIRED`

*Defense in depth*: Accessing or passing parameters labeled as `secret` automatically elevates the risk of any operation to `CRITICAL`, strictly triggering an approval requirement.

## Exact Execution Binding
Approvals are not broad entitlements. When a human approves an operation, the `approval_id` is cryptographically bound to the exact `idempotency_key` of that specific execution (actor, tool, normalized arguments). Modifying a single character in a command string invalidates the approval, requiring a completely new request.

## Prompt Injection Resistance
The `ApprovalRegistry` treats all LLM-provided arguments (even those containing keys like `"approved": "true"`) strictly as canonical data strings for the execution footprint. LLM outputs cannot manipulate the approval state machine because they exist on the wrong side of the authorization boundary.

## Expiration & Fail-Closed Semantics
Approval requests default to `PENDING` and expire after a strict temporal deadline. An expired, unknown, or malformed approval status explicitly fails closed, blocking execution.

## Future Integration Boundaries
The `ApprovalRegistry` currently exists in-memory to support deterministic automated testing. The interface is purposefully abstract, enabling future seamless integration with distributed persistence (e.g., PostgreSQL), web UI dashboards, or external OAuth control planes.
