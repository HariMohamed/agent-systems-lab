# OpenAI Provider Adapter Report

## Implementation
The repository now features a concrete, minimal `OpenAIAdapter` capable of driving the agent evaluation process using real LLM models (e.g., `gpt-4o-mini`). This adapter is securely encapsulated behind the abstract `ProviderAdapter` boundary and interfaces with the internal evaluation loops, allowing real end-to-end integration tests to occur *without* exposing the host machine to arbitrary untrusted output from the LLM.

## Architecture
- **Boundary Separation:** The adapter converts internal evaluation tasks into the OpenAI Chat completions payload, including translating internal JSON tools into structured OpenAI Function schemas.
- **Decoupled execution:** The adapter only returns a structured `{ "type": "tool_request", "tool": "X" }` payload. It has absolutely no ability to directly execute host shell commands, keeping the LLM as an unprivileged planner.

## Authentication
Execution of real models is **opt-in only** via the CLI flag: `--provider openai`.
By default (`--provider mock`), or if `openai` is not installed, or if the `OPENAI_API_KEY` is not set, the evaluation cleanly falls back to a deterministic path or returns `BLOCKED`.

## Secret Handling
- Environment variables containing keys are never serialized to the evaluation trace.
- A defensive redaction loop automatically scrubs recognizable secrets (e.g. `sk-`) from the context window payload before making the HTTP request, mitigating risks where sensitive strings might leak into the trace metadata via LLM regurgitation.
- Dummy tokens are used exclusively in automated testing.

## Request Boundary
We explicitly send only:
1. System instructions composed from `SKILL.md`.
2. Scenario tasks and fixture content.
3. Defined strict tool function schemas.

No Git credentials, environment variables, or other files are blindly appended to the prompt.

## Response Boundary
OpenAI's tool calls are structurally unwrapped and translated into the evaluator's normalized interface. Any exceptions or SDK timeouts are caught and converted to `{"type": "error"}` to prevent unhandled tracebacks.

## Tool Security
**Critical Check:** The LLM does NOT execute tools. It requests them. The request goes to the `ToolPolicyEngine`, which enforces authorization (e.g., blocking network access). If authorized, it passes to the Sandbox. Unknown or malformed tools hallucinated by the model are automatically `DENIED`.

## Agent Loop
The `LLMAgentAdapter` binds the provider logic into a multi-turn conversation loop, bounded to a maximum of **10 turns**. If the model attempts infinite looping, execution is forcefully halted.

## Timeout
Provider HTTP calls are bounded to a maximum `30.0s` timeout directly via the OpenAI SDK, preventing hangs.

## Retry
No aggressive retries are implemented. Transient failures must be explicit in evaluations (treated as an ERROR state rather than failing silently), adhering to strict determinism wherever possible.

## Cost Control
The default model is mapped to `gpt-4o-mini`, mitigating accidental cost overruns. Testing relies heavily on small, bounded fixtures.

## Tests
- `test_missing_openai_key_returns_blocked`: Proves that a lack of credentials explicitly blocks the evaluation instead of falling back to insecure defaults.
- `test_openai_api_key_scrubbing`: Uses a mock request handler to prove that defensive `[REDACTED]` scrubbing intercepts keys that are leaked into the message payload.

## Results
- Deterministic paths and security regressions remain completely operational (`PASS`).
- Missing credentials correctly halt real mode (`BLOCKED`).

## Docker Limitation
As previously identified, the `run_command` Docker sandbox remains offline on the host machine. Testing against the OpenAI provider natively proves the reasoning and structured parsing loop, but true sandbox side effects remain `BLOCKED`.

## Residual Risks
The current redaction relies on simple string matching (`sk-`). More advanced obfuscated key extraction might still bypass the logger redaction if an LLM is intentionally adversarial.

## Next P0
In future iterations, implement a localized LLM-as-a-judge system to verify the semantic quality of the model's responses, as exact-string assertions (like those used in the deterministic tests) are too rigid for generalized intelligence evaluation.
