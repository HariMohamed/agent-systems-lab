# Dynamic Tool Scopes

## Overview
This document defines the authorization model implemented within `ToolPolicyEngine` for agent tool execution. Unlike simple binary capability flags (e.g., allow all network, deny all network), the V2 model implements granular, actor-aware Authorization Contexts.

## Threat Model
In multi-agent systems, subagents are spawned dynamically to handle specific, narrow tasks. If authorization is treated globally, a compromised or hallucinating "Researcher" subagent might invoke `run_command` with destructive effects. The LLM cannot be trusted to limit itself. The capability MUST be governed by an external policy engine.

## Authorization Context
The authorization state is passed explicitly to the PolicyEngine on every evaluation loop. It contains:
- `actor_id`: Identity of the requester.
- `allowed_tools`: The exact list of tools the actor is permitted to invoke.
- `scopes`: Resource bounds (`network`, `secret`, `filesystem`).
- `approval_state`: Tracks HITL (Human-in-the-Loop) state.

## Scope Model & Inheritance
A parent agent can dispatch a child agent, passing along a requested subset of permissions.
The Policy Engine validates `delegate_agent` mathematically:
- **Child Scopes ≤ Parent Scopes.**
- Any attempt to grant a child agent permissions exceeding the parent results in a `DENY` policy violation.

### Resource Restrictions
- **Filesystem Scope:** Defines exact path prefixes an agent is allowed to access. Path traversals (`../`) and absolute escape routes (e.g., `~`, `/etc`) are explicitly blocked before physical sandbox evaluation.
- **Network Scope:** Explicitly tracked as `allowed` or `none`.
- **Secret Scope:** By default `deny`. The engine explicitly blocks tools containing the word `secret` as a secondary defense layer if secret access is not authorized.

## Approval States
To prepare for future HITL gates, the engine understands `not_required`, `required`, `approved`, and `denied`. If an action's state is `required` but not `approved`, the policy explicitly fails closed.

## Fail-Closed Behavior
The Policy Engine ensures any ambiguity evaluates to `DENY`:
- Unknown tool requested.
- Unknown actor.
- Missing context.
- Scope escalation attempt.
- Path traversal attempt.
- Missing approval.
