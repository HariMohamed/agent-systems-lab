# LLM Provider Execution Model

## Overview
To transition from the `DeterministicMockAgent` to real large language models (LLMs), the evaluation harness introduces a strict boundary separating the internal evaluation logic from external API providers. This ensures the harness remains agnostic, secure, and independent of specific SDKs (e.g., OpenAI, Anthropic, Google).

## Architecture

The integration follows a layered delegation pattern:

```text
Evaluation Harness
        ↓ (Context, Task, Available Tools)
AgentAdapter (Abstract Interface)
        ↓ (System Prompt, Formatted Instructions)
ProviderAdapter (Vendor-Specific Implementation)
        ↓ (Network Request)
External LLM API
```

### 1. Evaluation Harness
Constructs the evaluation environment by loading the static `SKILL.md` file, the fixture task, the tool schemas, and evaluating the chronological trace against predefined assertions.

### 2. AgentAdapter
An abstraction that normalizes the harness's concepts (Tasks, Skills, Tools) into the standard text/chat payloads required by LLMs. It defines how a specific agent loop should run (e.g., handling tool calls, re-prompting on policy denial).

### 3. ProviderAdapter
A vendor-specific client wrapper (e.g., `OpenAIAdapter`, `AnthropicAdapter`, `MockProviderAdapter`).
- **Responsibilities:**
  - Handles authentication and network communication.
  - Translates internal tool schemas into the vendor's specific function-calling format (if supported) or JSON instruction format.
  - Translates the vendor's API response back into the standard `{"type": "tool_request"}` or `{"type": "response"}` dictionary format expected by the trace.

## Security Constraints

1. **Explicit Opt-In:** Real LLM providers must only be invoked if explicitly requested via CLI (e.g., `--provider openai`). Default execution remains `deterministic_mock`.
2. **Credential Isolation:** API keys must be injected securely via environment variables (e.g., `OPENAI_API_KEY`) and NEVER committed to repository fixtures.
3. **Trace Scrubbing:** The `ProviderAdapter` must ensure that authentication headers and raw host secrets do not leak into the evaluation trace.
4. **No Side-Channel Execution:** LLM responses must be strictly filtered through the `ToolPolicyEngine`. The provider has no direct access to host resources, network, or the Docker daemon.

## Next Steps
1. Define the abstract `AgentAdapter` and `ProviderAdapter` classes in `scripts/evaluate.py`.
2. Implement a `MockProviderAdapter` to validate the interface translation without incurring API costs.
3. Add a `--provider` flag to the CLI.
