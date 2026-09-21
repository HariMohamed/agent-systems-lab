# V2 Ecosystem Roadmap & Top 10 Priorities

Based on the V1 Security Audit, the Ecosystem Research, and the Gap Matrix, this roadmap outlines the strategic direction for `agent-systems-lab`.

## Anti-Bloat Principle
The repository optimizes for **QUALITY > COUNT**. We will not create a new skill unless it solves a concrete capability gap unsupported by the current architecture.

---

## Top 10 Implementation Candidates

### 1. Dynamic Tool Scopes (P0) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** SYSTEM-DESIGN
- **Why now:** Currently, the `PolicyEngine` globally allows or denies a tool (e.g., `run_command`). If a subagent is dispatched for research, it should only have `read_only` scope, preventing accidental destructive commands.
- **Evidence:** LangGraph and CrewAI implement scoped worker agents. OAuth2 models demonstrate the necessity of principle-of-least-privilege.
- **Current gap:** Binary global authorization.
- **Risk:** High security value. Low implementation risk.
- **Expected value:** Eliminates whole classes of subagent privilege escalation vectors.

### 2. Human-in-the-Loop (HITL) Approval Gates (P0) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** POLICY & EVALUATION & SYSTEM-DESIGN
- **Why now:** Autonomous systems cannot safely execute destructive state changes (e.g., dropping a database, spending money) without a semantic pause for human confirmation.
- **Evidence:** Anthropic's orchestration guidelines explicitly mandate HITL for destructive tools. LangGraph `interrupt` mechanics.
- **Current gap:** No mechanism for the harness to pause and solicit human input.
- **Risk:** High security value. Medium implementation complexity.
- **Expected value:** Prevents catastrophic unrecoverable actions.

### 3. Idempotent Tool Execution Guidelines (P1) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** POLICY & SYSTEM-DESIGN
- **Why now:** If an agent encounters a transient network error and retries a tool execution, non-idempotent tools will duplicate side effects.
- **Evidence:** Temporal workflow paradigms. Standard distributed systems engineering.
- **Current gap:** Tools are assumed safe to retry indefinitely.
- **Risk:** Medium operational risk (data corruption).
- **Expected value:** Ensures safe failure recovery.

### 4. State Checkpointing & Resume (P1) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** SYSTEM-DESIGN
- **Why now:** Long-running evaluations (or multi-step tasks) that fail at step 9 currently lose all progress and trace context.
- **Evidence:** LangGraph's native SQLite/Postgres Checkpointers.
- **Current gap:** Harness trace exists entirely in volatile memory.
- **Risk:** Low security risk. High developer experience impact.
- **Expected value:** Saves compute cost and time on failures.

### 5. Explicit Memory Management (P1) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** SKILL
- **Why now:** Context windows bloat rapidly. Agents need the capability to explicitly save and retrieve relevant facts across sessions.
- **Evidence:** Letta (MemGPT) `core_memory_append` tools; Mem0 architecture.
- **Current gap:** Memory is purely thread-based and disappears after the evaluation loop.
- **Risk:** Privacy/data leakage risk if memory is shared inappropriately.
- **Expected value:** Enables long-term, cross-session agent intelligence.

### 6. Trace Telemetry & Cost Tracking (P1)
- **Artifact Type:** SYSTEM-DESIGN
- **Why now:** We log traces, but do not capture token usage, latency, or dollar cost per evaluation scenario.
- **Evidence:** LangSmith, Helicone, standard LLMOps platforms.
- **Current gap:** Missing metrics layer in `evaluate.py`.
- **Risk:** Low.
- **Expected value:** Allows benchmarking of skill efficiency, not just correctness.

### 7. Supervisor Orchestration Pattern (P1) - [IMPLEMENTED / VERIFIED]
- **Artifact Type:** SYSTEM-DESIGN
- **Why now:** We have peer-to-peer handoffs (`agent-routing`), but lack a formalized state machine for a central supervisor directing a static graph of workers.
- **Evidence:** LangGraph Supervisor patterns.
- **Current gap:** No hierarchical orchestration defined.
- **Risk:** Low.
- **Expected value:** Provides a predictable alternative to dynamic routing for highly constrained workflows.

### 8. Automated Semantic Loop Detection (P2)
- **Artifact Type:** EVALUATION / SCRIPT
- **Why now:** The harness relies on a hard `max_turns=10` limit. If a model gets stuck repeating the exact same failed tool call, it burns tokens until it hits 10.
- **Evidence:** Common failure modes observed in AutoGen and open-source models.
- **Current gap:** No intelligent detection of repetitive state generation.
- **Risk:** Cost exhaustion.
- **Expected value:** Fails faster and cheaper.

### 9. Fallback LLM Routing (P2)
- **Artifact Type:** SYSTEM-DESIGN
- **Why now:** If the primary provider (OpenAI) rate limits or goes down, the evaluation crashes.
- **Evidence:** Vercel AI SDK fallback mechanisms.
- **Current gap:** Single provider dependency in `evaluate.py`.
- **Risk:** Low.
- **Expected value:** Increased reliability.

### 10. Adversarial Skill Fuzzing (P2)
- **Artifact Type:** WORKFLOW
- **Why now:** Static JSON evaluations do not catch adaptive LLM prompt injections.
- **Evidence:** Red-teaming frameworks (e.g., Garak, Promptfoo).
- **Current gap:** Security evaluations are deterministic only.
- **Risk:** Medium (requires careful sandbox isolation).
- **Expected value:** Discovers novel jailbreaks in skills.

---

## Final Decision & Next Action

**Deprecate/Merge:**
- Deprecate `dispatching-parallel-agents`, `subagent-driven-development`, `using-superpowers`, `using-git-worktrees`, `receiving-code-review`, `requesting-code-review`.
- Merge planning skills into a single `systematic-planning` workflow.

**THE NEXT SINGLE HIGHEST-VALUE IMPLEMENTATION:**
**Dynamic Tool Scopes (P0)**

*Why:* The current V1 architecture successfully isolated the provider, but the `PolicyEngine` still treats authorization globally. If an agent delegates to a "Researcher" subagent, that subagent inherits the ability to run arbitrary system commands if `run_command` is globally enabled for the scenario. Implementing Dynamic Tool Scopes in the `PolicyEngine` (e.g., scoping the subagent strictly to `read_file` and `network_request` while denying `run_command` and `write_file`) is the most critical missing security mechanism for safe orchestration.
