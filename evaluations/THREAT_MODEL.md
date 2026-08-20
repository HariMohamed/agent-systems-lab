# Evaluation Infrastructure Threat Model

## Overview
This document models the threats against the dynamic evaluation sandbox designed to execute and assess agent skills and scripts. Since agent skills contain untrusted third-party instructions and executable code, evaluating them poses a direct risk to the host environment.

## 1. Assets
- **Evaluation Controller (Host):** The machine running the evaluation pipeline. Contains repository secrets, host filesystem, and network access.
- **Evaluation Results:** The integrity of the test outcomes.
- **Host Network & Credentials:** Internal network topology, cloud credentials, SSH keys, etc.

## 2. Attack Surface
- The evaluation fixture parser (processing untrusted JSON).
- The sandbox runtime (execution of untrusted scripts or prompt payloads).
- The result extraction and assertion phase (parsing output from the sandbox).

## 3. Trust Boundaries
- **Untrusted:** The skill being evaluated, its scripts, and the evaluation fixtures.
- **Trusted:** The evaluation controller, the Docker daemon (host side), and the assertion engine.
- **Boundary:** The container isolation layer (namespaces, cgroups, seccomp).

## 4. Security Controls

| Property | Status |
|---|---|
| Context Compilation (Untrusted Isolation) | VERIFIED |
| Secret non-disclosure | VERIFIED |
| Resource Exhaustion (Tokens/Agents) | VERIFIED (Control Plane Limits) |
| Provider authentication | VERIFIED (when explicitly configured) |
| Explicit Scope Authorization | VERIFIED |
| No privilege self-escalation | VERIFIED |
| Child scope subsets | VERIFIED |
| Idempotency Key deterministic | VERIFIED |
| Non-idempotent retry denial | VERIFIED |
| Cross-actor execution isolation | VERIFIED |
| No model self-approval (HITL) | VERIFIED |
| Expiration bounds (HITL) | VERIFIED |
| Immutable execution binding (HITL) | VERIFIED |
| Bounded orchestration depth | VERIFIED |
| Handoff sanitization (Injection resistance) | VERIFIED |
| State ownership isolation | VERIFIED |
| State identity immutability | VERIFIED |
| Optimistic concurrency (Lost-update prevention) | VERIFIED |
| State bounds limits | VERIFIED |
| Memory explicitly provenanced | VERIFIED |
| Memory cannot self-escalate trust | VERIFIED |
| Memory content cannot authorize execution | VERIFIED |
| Sibling memory strict isolation | VERIFIED |
| Memory bounds limits | VERIFIED |
| Docker filesystem isolation | NOT VERIFIED |
| Docker network isolation | NOT VERIFIED |
| Docker resource limits | NOT VERIFIED |
| No host fallback | VERIFIED |
| Bounded model loop | VERIFIED |
| Explicit opt-in for real provider | VERIFIED |
| Tool Policy boundaries | VERIFIED |
| Ephemeral environments | DESIGNED |

## 5. Security Principles
1. **Deny by Default:** Network, write access, and environment variables are blocked unless explicitly required by the fixture schema. Unknown tools are strictly denied.
2. **Data Minimization:** Only exactly required properties (fixture content, skill content) are supplied to LLMs.
3. **No Real Secrets:** Only synthetic dummy tokens are injected for security testing. Real credentials are never checked into fixtures and are scrubbed defensively from traces.

## 6. Known Limitations
- Docker on Windows (Docker Desktop/WSL2) provides strong isolation, but WSL2 networking and filesystem mapping have specific nuances. 
- Docker isolation is currently NOT VERIFIED because the local daemon is unavailable, meaning actual sandbox side effects are `BLOCKED`.
- LLM-based skills that require live API access cannot be fully evaluated in `--network none` without an internal mock server, which is out of scope for V1.
