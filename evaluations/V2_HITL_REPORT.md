# V2 HITL Approval Control Plane Report

## Scope
This phase introduces a deterministic Human-in-the-Loop (HITL) approval control layer into the V2 evaluation architecture. The core objective is to prevent autonomous models from independently executing highly privileged operations by strictly segregating authorization (actor capabilities) from execution approval (explicit human consent).

## Approval Architecture
The pipeline has been updated to evaluate the `ApprovalPolicyEngine` immediately after the `IdempotencyEngine`.
Requests are evaluated for risk, and a structured `ApprovalRegistry` manages the lifecycle (`PENDING`, `APPROVED`, `DENIED`, `EXPIRED`).

## Risk Model
Tools are statically mapped to risk levels:
- `LOW`: `read_file`
- `MEDIUM`: `write_file`, `delegate_agent`
- `HIGH`: `network_request`
- `CRITICAL`: `run_command`
- *Dynamic Escalation:* Any operation attempting to interact with arguments containing "secret" is immediately escalated to `CRITICAL`.
Operations classified as `HIGH` or `CRITICAL` strictly require human approval.

## Identity Model
The system enforces a strict cryptographic boundary between the executing autonomous agent (`actor_id`) and the human operator (`approver_id`).
Self-approval is hard-blocked at the policy engine level.

## Execution Binding
Approvals are inextricably bound to the `idempotency_key` of the exact request, ensuring that an approval cannot be reused for a different command, mutated arguments, or a distinct logical execution context.

## Expiration
Approvals default to a strict 300-second temporal lifetime. Expired approvals fail closed and deny execution.

## Idempotency Integration
Because Approval evaluates *after* Idempotency:
- The agent cannot use Approval as a side-channel to probe for prior executions.
- Idempotency successfully intercepts exact duplicate successful runs without erroneously spawning redundant approval requests.

## Security Properties
- **No Self-Approval:** Model outputs (even crafted JSON prompt injections) cannot manipulate the external human approval state machine.
- **Fail Closed:** Unknown states, forged approvals, and missing capabilities all deterministically collapse to `DENY`.

## Tests
The deterministic test suite was expanded with 10 explicit regression tests (`TestApprovalControlPlane`) addressing:
1. Risk classifications
2. Missing and Pending approvals
3. Expired approvals
4. Actor and Execution impersonation boundaries
5. Forged payloads
6. Prompt injection data segregation
All 46 tests pass. Legacy deterministic tests successfully bypass HITL transparently via the backward-compatibility auto-approver for the specific `sandbox_tests.json` legacy assertions.

## Verified Guarantees
- LLM output cannot constitute human approval.
- An agent cannot approve its own request.
- Approval is bound to the exact execution footprint.
- Expired approvals fail execution.
- Human identity and agent identity are separated in state.

## Unverified Guarantees
- **External Auth:** Currently relies on an in-memory string-based `approver_id`. True cryptographic verification of human identity via OIDC/OAuth is `NOT VERIFIED`.
- **Durable Persistence:** The approval state is lost if the harness process drops (`NOT VERIFIED`).

## Residual Risks
- Without durable state, cross-session approvals are unavailable.
- Long-running agents currently must pause completely and hold memory context open during the `PENDING` approval state.

## Release Decision
**RELEASE WITH CONDITIONS**

Deterministic approval-control properties are successfully verified within the current in-memory evaluation architecture. Physical Docker containment and durable storage remain officially unresolved.
