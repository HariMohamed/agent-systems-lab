# Hierarchical Multi-Agent Orchestration

## Overview
The V2 Multi-Agent Orchestration layer models a deterministic actor hierarchy where a supervisor agent dispatches explicit tasks to specialized subagents. Crucially, the supervisor functions strictly as an *orchestrator*, not a security authority. All delegations, permissions, and tool requests pass through the centralized evaluation and policy engines.

## Actor Hierarchy
Every agent has a designated identity (`actor_id`). Subagents spawned via delegation explicitly possess a `parent_actor_id` which mathematically constraints their capabilities.

## Capability Down-Scoping (Delegation Contract)
Delegation adheres to the Strict Capability Subset rule:
`CHILD CAPABILITIES ⊆ PARENT CAPABILITIES`

A supervisor cannot grant a child agent capabilities (tools, network scopes, directory access) that it does not itself possess. This prevents a read-only researcher from spawning an executing admin agent.

## Handoff Validation
Child outputs are inherently untrusted strings. The `OrchestrationController` strictly validates the result payload returned from a subagent back to the supervisor:
- Schema conformance
- Identity binding (`agent_id`, `task_id`)
- Allowed statuses (`SUCCEEDED`, `FAILED`, `CONFLICT`, `REJECTED`)
- Sanitization of output (stripping injected properties intended to bypass state)

## Security Boundaries
1. **Tool Execution:** Supervisors do not have a special `bypass_security()` path. Delegations are evaluated strictly through the `PolicyEngine` -> `IdempotencyEngine` -> `ApprovalPolicyEngine` pipeline.
2. **Untrusted Output:** A child returning `{"status": "SUCCEEDED", "approval_granted": "true"}` does not alter external validation controls.
3. **Cross-Actor Isolation:** Subagents cannot read their sibling's private state, trace history, or access their parent's private memory unless explicitly passed down via the context argument.

## Bounded Execution
Unrestricted recursive spawning is dangerous and costly. The orchestration engine enforces explicit finite resource limits:
- `max_agents`: The total number of active children simultaneously allowed per scenario.
- `max_depth`: The maximum recursion level a delegation graph may achieve.
Defaulting to safe finite parameters completely mitigates unbounded self-replication.
