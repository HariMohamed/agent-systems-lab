# V2 Skill Ecosystem Gap Matrix

This matrix evaluates the current coverage of essential AI agent capabilities within `agent-systems-lab`, identifying structural gaps based on V1 architecture and external ecosystem research.

| Capability | Current Coverage | Gap | Existing Artifact | Overlap / Redundancy | Risk | Priority | Recommended Action |
|------------|------------------|-----|-------------------|----------------------|------|----------|--------------------|
| **Routing / Delegation** | STRONG | None | `agent-routing` | `dispatching-parallel-agents`, `subagent-driven-development` | Low | Maintain | Deprecate overlapping skills. Merge unique context into `agent-routing`. |
| **Pre-completion Verification** | STRONG | None | `verification-before-completion` | None | Low | Maintain | Keep as a core workflow. |
| **Systematic Debugging** | GOOD | Missing trace context | `systematic-debugging` | None | Low | Maintain | Keep as a core workflow. |
| **Untrusted Content Handling** | STRONG | None | `untrusted-content-handling` | None | Low | Maintain | Key defense against indirect injection. |
| **Skill Security Auditing** | STRONG | None | `skill-security-audit` | None | Low | Maintain | Key repository pipeline tool. |
| **Task Planning** | PARTIAL | Fragmented workflows | `writing-plans`, `executing-plans` | `brainstorming`, `test-driven-development` | Low | P2 | Consolidate into a single `systematic-planning` SYSTEM-DESIGN document. |
| **Tool Authorization / Scopes** | PARTIAL | Binary global allow/deny | None (Handled via code in `PolicyEngine`) | None | High | P0 | Implement dynamic, per-agent/per-task tool scopes (e.g., `read_only`). |
| **Human-in-the-loop (HITL)** | NONE | No explicit approval state | None | None | High | P0 | Create a POLICY and evaluation capability for approval gates on destructive actions. |
| **Idempotent Tool Execution** | NONE | Tools are assumed safe to retry | None | None | Med | P1 | Create a POLICY defining idempotency requirements for state-mutating tools. |
| **State Checkpointing** | NONE | Run fails completely if interrupted | None | None | Low | P1 | Implement SYSTEM-DESIGN for resuming failed evaluations/tasks. |
| **Explicit Memory Management** | NONE | Context relies on automated RAG or full history | None | None | Low | P1 | Create a SKILL for long-term memory read/write. |
| **Observability / Telemetry** | PARTIAL | Basic JSON trace exists | `observability-investigation` (Targeted at infra, not the agent itself) | None | Low | P1 | Expand trace schema to include token counts, costs, and latency. |
| **Supervisor Orchestration** | NONE | Only peer-to-peer handoffs exist | None | None | Low | P1 | Create a SYSTEM-DESIGN document for hierarchical agent state machines. |
| **Automated Loop Detection** | PARTIAL | Hardcoded max turns | None | None | Low | P2 | Implement semantic loop detection in the harness. |
| **Adversarial Fuzzing** | NONE | Static JSON scenarios only | None | None | Med | P2 | Create a WORKFLOW for dynamic LLM red-teaming of skills. |

## Duplication Analysis
The initial repository ingestion included excessive "process" skills from other frameworks.
- **Recommendation:** Reject `using-superpowers`, `using-git-worktrees`, `receiving-code-review`, and `requesting-code-review` as bloat. They are not distinct agent capabilities, but generic software engineering instructions that waste token context.
- **Recommendation:** Consolidate `dispatching-parallel-agents` and `subagent-driven-development` into `agent-routing`.
- **Recommendation:** Consolidate `writing-plans`, `executing-plans`, and `brainstorming` into a single `systematic-planning` workflow.
