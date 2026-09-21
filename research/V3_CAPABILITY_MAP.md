# V3 Capability Map

```mermaid
graph TD
    subgraph Governance & Evaluation
        Eval[Evaluation Framework] --> Trace
        Eval --> Assertions[Deterministic Assertions]
        Eval -.-> LLMJudge[LLM-as-a-Judge: MISSING]
        Gov[Governance] --> Prov[Provenance YAML]
        Gov -.-> Supply[Skill Supply Chain SBOM: MISSING]
    end

    subgraph Orchestration & State
        Agent[Agent Identity] --> Orch[Orchestration Controller]
        Orch --> Subagent[Child Agent]
        Agent --> State[State Store]
        Agent --> Mem[Memory Store]
        State -.-> Durable[External Durable DB: MISSING]
        Orch -.-> P2P[Peer-to-Peer Routing: MISSING]
    end

    subgraph Security Control Plane
        Agent --> Policy[Tool Policy Engine]
        Policy --> Idemp[Idempotency Engine]
        Idemp --> Approval[HITL Approval Engine]
        Approval --> Sandbox[Execution Sandbox]

        Policy --> Scope[Dynamic Scopes]
        Idemp --> Retry[Safe Retries]
        Policy -.-> Budgets[Resource/Cost Budgets: MISSING]
    end

    subgraph Infrastructure
        Adapter[Provider Adapter] --> LLM[OpenAI API]
        Adapter -.-> Fallback[Fallback Router: MISSING]
        Trace[Execution Trace] -.-> OTel[OpenTelemetry / Metrics: MISSING]
    end
```

## Missing Edges & Nodes
- The Execution Trace is not connected to a standard Observability layer (e.g., OpenTelemetry, cost/latency tracking).
- The Orchestration Controller lacks horizontal routing (P2P / Blackboard) patterns.
- The Security Control Plane lacks Resource Budgets (token limits, API request rate limits per agent).
- The Provider Adapter lacks fallback routing and circuit breakers.
- The Evaluation Framework relies strictly on deterministic assertions and lacks behavioral scoring via LLM Judges.
- The Governance system lacks formal SBOM or cryptographic integrity checks for third-party skills.
