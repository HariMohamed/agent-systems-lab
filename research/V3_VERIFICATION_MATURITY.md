# V3 Verification Maturity Model

## Maturity Levels
- **L0:** Undocumented
- **L1:** Documented
- **L2:** Statically checked (e.g., Code Review, Linting)
- **L3:** Deterministic tests (In-memory, Mocked components)
- **L4:** Isolated dynamic tests (Local Docker, Real providers)
- **L5:** Adversarial dynamic tests (Red-teaming, Fuzzing)
- **L6:** Production-like distributed validation (Kubernetes, Postgres, Temporal)

## Security Property Mapping

| Property | Current Level | Target Level | Gap Description |
|---|---|---|---|
| Unbounded API cost | L3 | L4 | BudgetEngine implemented; lacks multi-node enforcement |
| Infinite loop / exhaustion | L3 | L4 | Logical execution bounds verified; physical limits blocked |
| Untrusted tool execution | L3 | L5 | Safely blocked or required HITL. Physical container unverified |
| Explicit Scope Authorization | L3 | L4 | Tested deterministically; lacks real LLM capability tests |
| Child scope subsets | L3 | L3 | Conceptually mathematical; L3 is sufficient |
| Idempotency Key deterministic | L3 | L4 | Tested deterministically; lacks real network failure tests |
| Cross-actor execution isolation | L3 | L6 | Tested in-memory; lacks true process/pod separation |
| No model self-approval (HITL) | L3 | L4 | Tested deterministically; lacks human UI integration |
| Bounded orchestration depth | L3 | L3 | Conceptually mathematical; L3 is sufficient |
| Handoff sanitization (Injection) | L3 | L5 | Needs adversarial red-teaming (L5) |
| State ownership isolation | L3 | L6 | Tested in-memory; lacks Postgres Row-Level Security |
| State identity immutability | L3 | L6 | Tested in-memory; lacks database constraints |
| Optimistic concurrency | L3 | L6 | Tested sequentially; lacks real concurrent workers |
| Memory explicitly provenanced | L3 | L4 | Tested deterministically; lacks vector DB provenance |
| Memory poisoning resistance | L3 | L5 | Resolved (L3 ContextCompiler adversarial tests). Needs red-teaming fuzzing (L5) |
| Secret non-disclosure | L3 | L4 | Basic regex redaction; lacks external Vault integration |
| Docker filesystem isolation | L1 | L4 | Configured but untested (Daemon unavailable -> BLOCKED) |
| Docker network isolation | L1 | L4 | Configured but untested (Daemon unavailable -> BLOCKED) |
| Skill supply-chain integrity | L3 | L4 | Deterministic hash verification implemented. Lacks external signatures |
