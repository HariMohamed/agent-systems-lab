# V3 Implementation Roadmap

## TOP 3 P0 Priorities
1. **Physical Docker Sandbox Verification** - [BLOCKED - DAEMON UNAVAILABLE]
   - *Why:* The current architecture evaluates sandbox logic but fails closed because Docker is unverified.
   - *Dependencies:* Host Docker environment.
   - *Security Impact:* Critical (prevents RCE).

2. **Supply-Chain Integrity (SBOM / Signed Artifacts)** - [IMPLEMENTED]
   - *Why:* We pull external skills. Without integrity hashes, we are vulnerable to dependency poisoning.
   - *Dependencies:* Catalog validator.
   - *Security Impact:* Critical (prevents supply-chain attacks).

3. **Context Engineering (Trust & Injection Boundaries)** - [IMPLEMENTED]
   - *Why:* Expanding Memory and Multi-Agent contexts increases prompt-injection attack surface. We need a structured context compiler to isolate untrusted inputs.
   - *Dependencies:* MemoryStore, StateStore.
   - *Security Impact:* Critical.

## TOP 5 P1 Priorities
1. **Agent Cost & Resource Budgets**
   - *Why:* Prevent infinite loops, token exhaustion, and runaway API spend.
2. **OpenTelemetry / Observability**
   - *Why:* We need latency, cost, and causal graph visibility for production scaling.
3. **LLM-as-a-Judge Evaluation Framework**
   - *Why:* Deterministic assertions don't capture nuanced failure modes.
4. **Malicious MCP Server Isolation**
   - *Why:* Third-party MCP servers can compromise the host if not sandboxed properly.
5. **Distributed Durable Execution Backend**
   - *Why:* In-memory State/Memory stores will lose data on crash.

## TOP 5 P2 Priorities
1. **Fallback Provider Routing**
2. **Semantic Anomaly Detection**
3. **Reward Hacking Calibration**
4. **Cross-Tenant Cryptographic Separation**
5. **Peer-to-Peer / Blackboard Orchestration**

---

## SINGLE NEXT BEST IMPLEMENTATION
**LLM-as-a-Judge Evaluation Framework**

*Why:* Our boundaries (Authorization, Idempotency, Budget, HITL, Multi-Agent, State, Supply-Chain) are mathematically sound and deterministically verified. However, evaluating *behavioral accuracy* of prompts requires moving beyond string-matching assertions into LLM-as-a-judge tests. Building the framework to evaluate "did the agent actually do a good job" is the next foundational capability.
