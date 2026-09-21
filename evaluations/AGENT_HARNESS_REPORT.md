# Agent Evaluation Harness Report

## Architecture
The evaluation framework has been restructured to explicitly evaluate *skills* (static instructions) using a modular agent orchestration pipeline. We strictly separate the data (`SKILL.md`) from the runtime.

The pipeline components:
- `SkillLoader`: Reads the Markdown safely without parsing or executing embedded code snippets.
- `Scenario`: Defines the test constraints, input tasks, expected behavior, and assertions.
- `AgentAdapter`: Currently implemented as a `DeterministicMockAgent`. This abstraction guarantees the harness can support multiple vendors (OpenAI, Anthropic) in the future without coupling.
- `ToolPolicyEngine`: Mediates all tool requests. Ensures the agent cannot bypass security by raw text output (e.g. denying network access or risky tools).
- `Sandbox`: The Docker-based environment for tools executing side effects (e.g., `run_command`).
- `AssertionEngine`: Verifies chronological trace events to evaluate behavioral correctness.

## Execution Model
The model strictly expects structured output.
The trace captures the chronological flow of evaluation, including `agent_input`, `agent_output`, `tool_request`, `policy_decision`, and `tool_result`. This allows assertions to accurately verify if an agent *attempted* a tool and if the policy *denied* it, rather than just grepping a final text response.
See `EXECUTION_MODEL.md` for a full breakdown.

## Skill Loader
Implemented inside `scripts/evaluate.py`. It only reads the text of `SKILL.md`. It actively ignores runtime extensions, refusing to evaluate or dynamically execute shell snippets within the skill definitions.

## Agent Adapter & Deterministic Mock
The `DeterministicMockAgent` provides CI-friendly, repeatable testing without API costs, unpredictable LLM variance, or real-world risks. It strictly simulates preset behaviors (e.g. attempting to read a file, delegating a subagent, or producing a final response) to validate the integration pipeline and the Assertion/Policy engines.
This proves the *harness correctness*, but it does NOT prove *real LLM intelligence or real-world agent reliability*.

## Tool Policy
The `PolicyEngine` explicitly validates structured tool requests. Example: If `network_request` is called but the scenario's sandbox defines `network: false`, the policy forcefully injects a `DENY` decision into the trace and rejects the tool invocation.

## Sandbox Integration
The Docker sandbox wrapper remains fail-closed. If a tool request (like `run_command`) requires the sandbox, and Docker is unavailable (as it is on the current development machine), the sandbox explicitly returns `BLOCKED`.

## Trace Model
Traces are structured logs captured per scenario. Assertions scan these traces rather than relying on unstructured text output. For example, `tool_called` verifies that a `tool_request` event for a specific tool exists.

## Assertion Model
Supports `contains`, `not_contains`, `tool_called`, `tool_not_called`, `policy_denied`, `exit_code`, `status`, and `network_denied`.

## Security Model
- **No host fallback:** Sandbox bypass is impossible. Unavailability results in `BLOCKED`.
- **Policy Enforcement:** An agent cannot execute arbitrary strings on the host. All actions must map to approved structured tools, which are individually filtered.
- **CI Policy:** Since untrusted content is never executed directly on the host runner, deterministic mock-tests are safe for general CI environments.

## Tests
- Added deterministic mock-agent testing scenarios for:
  - `agent-routing` (simple delegation, missing evidence).
  - `untrusted-content-handling` (web instructions, tool injection).
  - `skill-security-audit` (malicious skill audit).
- Added Python `unittest` suite (`scripts/tests/test_harness.py`) to verify the individual harness components independently from the skill tests.

## Results
- `python scripts/tests/test_harness.py`: **PASS**
- `python scripts/evaluate.py --all`: **PASS** (Deterministic mock behaviors verified successfully).
- `python scripts/evaluate.py --security`: **BLOCKED** (Sandbox correctly detects missing Docker daemon and fails closed).

## Known Limitations
The current testing proves the harness configuration, policy enforcement, and fail-closed sandbox behavior. Actual containment and dynamic behavior verification remain blocked until the Docker daemon is available and a real provider adapter is securely connected.

## Future Provider Adapters
When adding real LLM providers (e.g., `OpenAIAdapter`), the implementation must:
1. Require explicit opt-in.
2. Ensure network dependency is declared in the scenario schema.
3. Manage API credentials strictly outside of fixtures (never commit keys).
4. Refuse to execute on sensitive host repository content.

## Next P0
Implement an explicit Opt-In Real Provider Adapter that can pass the agent tasks to an actual LLM in a secure, audited fashion, allowing end-to-end integration testing beyond the mock.
