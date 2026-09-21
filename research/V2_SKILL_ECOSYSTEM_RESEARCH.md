# V2 Skill Ecosystem Research: AI Agent Engineering Patterns

This document synthesizes current patterns and capabilities in AI agent engineering based on primary sources from frameworks like LangChain, LangGraph, Anthropic, Letta, Mem0, OpenHands, AutoGen, CrewAI, PydanticAI, Temporal, and Mastra.

## 1. Orchestration
**VERIFIED** capabilities across major frameworks:
- **Routing & Deterministic Orchestration (Anthropic):** Distinguishes between workflows (predefined paths) and agents (dynamic choices). Anthropic recommends workflows for predictability and limiting agent autonomy to bounds (e.g., 5-10 tools max) to reduce coordination risk.
- **Supervisor Pattern (LangGraph, CrewAI):** A central orchestrator routes requests to specialized workers. Highly effective for complex state management but can introduce latency.
- **Handoffs/Swarm Pattern (LangGraph, AutoGen):** Agents directly pass tasks and context to one another using specialized tools, removing the central bottleneck.
- **Parallel Execution (LangGraph, Temporal):** Utilizing fan-out mechanisms (like the `Send` API in LangGraph) to execute multiple agent paths concurrently and reduce overall execution time.

## 2. Tools
**VERIFIED** capabilities:
- **Schemas & Validation (PydanticAI, LangChain):** Strong typing using models like Pydantic ensures tool calls from the LLM match expected arguments before execution.
- **Idempotent Execution (Temporal, LangGraph):** Crucial for retries. Tools that alter state are designed to be idempotent or are wrapped in transactional checkpoints to prevent duplicate side-effects.

**DESIGNED** (Emerging/Best Practice):
- **Authorization:** Associating tools with scopes or user tokens so the agent cannot perform actions beyond the user's granted permissions.

## 3. Security
**VERIFIED** capabilities:
- **Sandbox (OpenHands):** Executing code and system tools within isolated environments (e.g., Docker containers) to prevent system compromise from generated code.
- **Secret Isolation:** Utilizing environment variables or secure vaults out of the LLM's direct context unless explicitly needed, preventing secret leakage in prompt traces.

**DESIGNED**:
- **Indirect Prompt Injection Defense:** Running specific pre-filtering or parsing untrusted web content via a separate lower-privileged "reader" agent to sanitize inputs before passing them to the main orchestrator.

## 4. Memory
**VERIFIED** capabilities:
- **Short-Term (Thread) Memory (LangGraph, AutoGen):** Retaining message history within a single conversation thread or execution trace.
- **Long-Term Memory (Mem0, Letta/MemGPT):** Persisting entities, preferences, and facts across sessions using vector databases or knowledge graphs.

**DESIGNED**:
- **Read/Write Policies:** Mem0 and Letta provide specific tools for agents to explicitly `core_memory_append` or `core_memory_replace`, giving the agent autonomy over its own context window management rather than relying purely on automated RAG.

## 5. Reliability
**VERIFIED** capabilities:
- **Checkpointing (LangGraph, Temporal):** Saving state at every node/step so that if a node fails, execution can resume exactly from the point of failure.
- **Retries & Circuit Breakers (Temporal, PydanticAI):** Automatically retrying transient tool failures (e.g., network timeouts) and employing circuit breakers for persistent API limits.

**NOT VERIFIED** (Still complex/brittle in practice):
- **Automated Loop Detection:** Native, foolproof mechanisms to detect when an LLM is stuck in a repetitive "thought -> tool failure -> identical thought" cycle, though hard limits (e.g., `recursion_limit` in LangGraph) act as a fallback.

## 6. Human-in-the-Loop (HITL)
**VERIFIED** capabilities:
- **Approval Gates (LangGraph):** Pausing graph execution using interrupts. The graph waits for a human user to review a proposed tool call (like sending an email or executing a transaction) before proceeding.
- **State Modification (LangGraph):** Allowing the human not just to approve, but to edit the agent's proposed action or state before resuming execution.

**DESIGNED**:
- **Reversibility:** Building undo tools for actions, allowing a human to reverse an agent's operation if a mistake is detected post-execution.
