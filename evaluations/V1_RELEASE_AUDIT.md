# V1 Release Security Audit

## Scope
This document details the security release audit for V1 of the Agent Systems Lab dynamic evaluation infrastructure. The scope covers the evaluation controller (`evaluate.py`), the deterministic and LLM-driven adapters, CI integration, tool policy enforcement, and credential boundary controls.

## Architecture
The infrastructure relies on a decoupled adapter pattern:
- **Evaluation Controller:** Manages evaluation state, parses JSON assertions, and loads inert `SKILL.md` text.
- **AgentAdapter:** Interfaces between the controller and behavior generation.
- **ProviderAdapter:** Communicates securely with external intelligence (e.g., OpenAI).
- **PolicyEngine:** Serves as the strict authorization gate for all proposed tool executions.
- **Sandbox:** Isolates side effects.

## Trust Boundaries
The LLM is treated uniformly as an **UNTRUSTED COMPONENT**. Any capability requests produced by the LLM (e.g., executing commands) are constrained to simple string output (the normalized tool request), which must then successfully pass the Policy Engine before ever interacting with the host environment. The Sandbox provides a secondary physical boundary against side-effects.

## Secret Handling
Secret tracking relies on **PREVENTION** and **DEFENSE-IN-DEPTH**:
- API credentials are not written into source code or config fixtures.
- The Agent prompt explicitly allow-lists data (task string, fixture content, skill instructions); it never serializes the host process environment.
- Any outgoing context window payload is parsed by a `sanitize_string` wrapper that explicitly replaces the active API key and aggressively matches general OpenAI `sk-` credential patterns, transforming them to `[REDACTED_KEY]`.
- Provider response error strings are also sanitized before being exposed to the harness logging loop.

## Provider Boundary
- Integration with OpenAI relies strictly on the official Python SDK, imported dynamically.
- If the SDK is missing or credentials are not supplied via the environment, the `OpenAIAdapter` fails closed, triggering a `BLOCKED` status or sanitized `ERROR`.
- Execution remains purely offline and deterministic by default (`--provider mock`). Real integration must be deliberately invoked via `--provider openai`.

## Tool Security
- Missing, unknown, or malformed tools hallucinated by the LLM are evaluated by the `ToolPolicyEngine` as an automatic `DENY`.
- The Provider Adapter translates OpenAI's structured tool payload JSON back into internal schemas. Invalid JSON arguments do not crash the harness but result in an empty arguments payload, which forces policy denial or sandbox failure.

## Agent Loop
- Execution operates within a tightly bounded `for _ in range(10):` loop.
- The OpenAI chat completion call specifies a rigid `timeout=30.0` bound.
- The model cannot infinite-loop the evaluation runner, mitigating API cost exhaustion and DoS risks.

## Error Handling
Provider errors (e.g., network timeouts or API limits) are properly caught and mapped to a normalized evaluation `error` state. To prevent information leakage in the evaluation report, internal exception objects are cast to strings and aggressively passed through the credential sanitization filter.

## CI Security
The repository leverages GitHub Actions `.github/workflows/ci.yml` strictly for offline schema validation and deterministic mock evaluations. The pipeline uses no secrets. Real integrations are effectively decoupled and can be driven locally with personal environment variables.

## Dependency Model
The system does not enforce a rigid package manager. For those running offline security evaluations, no external dependencies are strictly required (the script leverages native standard libraries). The `openai` SDK is only imported and utilized if users explicitly request that boundary.

## Sandbox Status
The `Sandbox` component correctly defaults to `BLOCKED` because the underlying Docker daemon relies on host tooling that is intentionally unavailable in the current test matrix. The runner safely handles this lack of sandbox execution without accidentally defaulting to raw shell evaluation.

## Test Matrix
Automated regression tests confirm:
- Deterministic defaults maintain 15/15 passes.
- Missing credentials enforce a `BLOCKED` state.
- Fake credential strings (`sk-secret12345678901234567890`) are verifiably replaced with `[REDACTED_KEY]` before network dispatch or logging.
- `ToolPolicyEngine` continues to deny unverified tools independently.
- `MockProviderAdapter` correctly processes boundaries, deliberately failing assertions when its preset responses misalign with tests.

## Verified Guarantees
- Secret non-disclosure in trace/report logs.
- Bounded model loops and timeouts.
- No unsafe fallback to host OS execution.
- Tool policy encapsulation.
- Provider abstraction.

## Designed Guarantees
- Ephemeral test teardowns.
- Docker read-only mounts.

## Unverified Guarantees
- Docker filesystem isolation.
- Docker network isolation (SSRF protection).
- Docker CPU/Memory resource exhaustion limits.

## Residual Risks
- The physical execution boundary relies on Docker, which has known nuanced limitations when used in WSL2/Windows.
- Obfuscated key extraction (e.g., tricking the model to base64 encode its initial system context) might bypass the `sanitize_string` regex logic if an active payload targets the harness itself.

## Release Decision

**RELEASE WITH CONDITIONS**

The infrastructure securely limits the LLM to an untrusted decision-making capacity and properly protects host credentials from implicit serialization. The deterministic evaluation suite works correctly. The remaining unverified element is physical Docker containment due to daemon unavailability, which the harness safely mitigates by blocking execution.
