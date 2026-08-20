# V3 Gap Matrix

| Capability | Current Status | Existing Artifact | External Evidence | Security Importance | Reliability Importance | Priority | Recommendation |
|---|---|---|---|---|---|---|---|
| Dynamic Tool Scopes | IMPLEMENTED | ToolPolicyEngine | LangGraph, CrewAI | Critical | Low | P0 | DONE |
| Idempotent Execution | IMPLEMENTED | IdempotencyEngine | Temporal, Restate | High | Critical | P0 | DONE |
| HITL Approval Gates | IMPLEMENTED | ApprovalPolicyEngine | Anthropic Guidelines | Critical | High | P0 | DONE |
| Supervisor Orchestration | IMPLEMENTED | OrchestrationController | LangGraph Supervisor | High | High | P1 | DONE |
| Persistent State | IMPLEMENTED | StateStore | Mem0, LangGraph Checkpoints | Medium | High | P1 | DONE |
| Memory Lifecycle | IMPLEMENTED | MemoryStore | Letta, Mem0 | High | High | P1 | DONE |
| Context Engineering | IMPLEMENTED | ContextCompiler | DSPy, LlamaIndex | Medium | High | P1 | DONE |
| Distributed Durable Execution | UNVERIFIED | StateStore (in-memory) | Temporal, Inngest | Low | Critical | P1 | EXTEND INFRASTRUCTURE |
| Observability (Tracing, Cost, Latency) | PARTIAL | Trace array in evaluate.py | LangSmith, OpenTelemetry | Low | Medium | P1 | EXTEND INFRASTRUCTURE |
| LLM-as-a-Judge Evaluation | MISSING | evaluate.py (deterministic) | Promptfoo, OpenAI Evals | Low | Medium | P2 | NEW INFRASTRUCTURE |
| Semantic Loop Detection | MISSING | evaluate.py (hard loop limit) | AutoGen limits | Low | High | P2 | EXTEND INFRASTRUCTURE |
| Fallback Provider Routing | MISSING | ProviderAdapter | Vercel AI SDK, LiteLLM | Low | High | P2 | EXTEND ADAPTER |
| Supply-Chain Provenance (SBOM) | IMPLEMENTED | SkillVerifier | SLSA, Sigstore | Critical | Low | P1 | DONE |
| Model/Resource Budgets | IMPLEMENTED | BudgetEngine | Anthropic/OpenAI Guidelines | High | High | P1 | DONE |
| P2P / Blackboard Orchestration | MISSING | None | CrewAI, AutoGen | Low | Medium | P3 | NEW WORKFLOW |
| Agent Data Governance (PII) | PARTIAL | Redaction in StateStore/MemoryStore | GDPR, SOC2 | High | Low | P2 | EXTEND POLICY |

