# V3 Threat Coverage Matrix

| Threat | Attack Surface | Current Defense | Evidence | Residual Risk | Missing Defense | Priority |
|---|---|---|---|---|---|---|
| Prompt Injection | Agent Input | Memory/State Sanitization | VERIFIED | Medium | Context compaction & trust filtering | P1 |
| Indirect Prompt Injection | Web Data / Sandbox File | Tool Policy boundaries | VERIFIED | Medium | Semantic anomaly detection | P2 |
| Tool Poisoning | MCP / External API | Policy Engine | VERIFIED | Low | - | - |
| Malicious MCP Servers | Extensibility Layer | Untrusted execution model | DETERMINISTIC_ONLY | Medium | Containerized tools | P1 |
| Confused Deputy | Multi-agent Handoff | Dynamic Scopes / Subset rule | VERIFIED | Low | - | - |
| Privilege Escalation | State/Memory payloads | Untrusted payload treating | VERIFIED | Low | - | - |
| Credential Leakage | Trace / State storage | Regex Redaction | VERIFIED | Low | Vault integration | P2 |
| Command Injection | `run_command` | HITL Approval | VERIFIED | Low | Container isolation (Physical) | P0 |
| Supply-chain attacks | `skills/` importing | SkillVerifier / Hash | VERIFIED | Low | External Sigstore signatures | P2 |
| Cross-tenant leakage | State/Memory Store | Actor ownership rules | VERIFIED | Low | Cryptographic tenant separation | P2 |
| Identity Spoofing | Handoff payloads | Orchestrator validation | VERIFIED | Low | Signed payloads | P3 |
| Approval Spoofing | HITL Registry | Strict identity check | VERIFIED | Low | - | - |
| Replay attacks | Idempotency engine | Expected version checks | VERIFIED | Low | - | - |
| Data-plane injection | Context Compiler | Boundary definition | VERIFIED | Medium | Fuzzer | P1 |
| Unbounded API Exhaustion | BudgetEngine | Control-Plane Limits | VERIFIED | Low | - | - |
| Agent Loop Hijacking | OrchestrationController | Max loop depth | VERIFIED | Low | Resource-aware budgets | P1 |
| Memory poisoning | ContextCompiler | Strict Parsing | VERIFIED | Medium | Red-team fuzzing | P1 |
| Race conditions | State update | Optimistic concurrency | VERIFIED | Low | Distributed locking | P2 |
| Resource Exhaustion | Loop processing | Max turns limit | VERIFIED | Medium | Token/Time Budgets | P1 |
| Recursive delegation | Orchestrator | Max depth/agents limits | VERIFIED | Low | - | - |
| Sandbox Escapes | Docker | Configuration | UNVERIFIED | High | Physical Docker verification | P0 |
| Trace Poisoning | Output trace | Sanitization | VERIFIED | Low | Read-only traces | P3 |
| Reward Hacking | LLM-as-a-judge | N/A | MISSING | N/A | Calibrated judges | P2 |
