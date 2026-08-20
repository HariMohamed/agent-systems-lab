# Agent Evaluation Execution Model

## Overview
The evaluation harness strictly separates the *skill definition* (static instructions) from the *execution environment* (agent, tools, sandbox). 

## Concepts

### 1. Skill
A static instruction artifact (e.g., `SKILL.md`). It contains the guidelines, patterns, and directives a real LLM is expected to follow. It is **not** an executable program.

### 2. Scenario
A controlled test case defined in JSON. It specifies the input task, the untrusted fixture content, the assigned agent behavior, and the assertions to run against the trace.

### 3. Agent (Adapter)
An abstraction representing the intelligent execution engine.
- Accepts: `skill text`, `scenario task`, `available tools`, `context`.
- Produces: Structured actions (tool calls or final responses).
- **Deterministic Mock Agent:** A test-only implementation that outputs predefined, structured responses to validate the harness logic without requiring a real LLM provider.

### 4. Tool
A capability exposed to the agent, defined by a schema. Examples:
- `read_file` (READ_ONLY)
- `run_command` (EXTERNAL_SIDE_EFFECT)
- `delegate_agent` (REVERSIBLE / ORCHESTRATION)

### 5. Skill Verifier (Supply-Chain)
Validates the cryptographic integrity (SHA-256) and review status of external skills before loading them. Fails closed if the hash is mismatched or the skill is unreviewed.

### 6. Context Compiler
The strict prompt boundary. Takes trusted system instructions and untrusted data (like task inputs or retrieved memory), and compiles them into physically isolated blocks, preventing prompt injection attacks from escalating into trusted authority.

### 7. Policy Engine & Authorization Context
The global authorization perimeter. It evaluates every requested tool call (and its arguments) against a strict ALLOW/DENY ruleset based on the agent's identity and dynamic scope. Unrecognized tools or arguments automatically fail closed.
- **Actor:** The identity requesting the tool (e.g., `primary_agent`, `subagent_1`).
- **Scope:** Granular restrictions on resources (e.g., specific `filesystem` prefixes, `network` allow/deny).
- **Enforcement:** The Policy Engine enforces `DENY` if the actor attempts to exceed their assigned scope or if a subagent requests permissions greater than its parent. Model output can never serve as its own authorization.

### 8. Idempotency Engine & Execution Registry
Ensures safe retry semantics and prevents duplicate side-effects. Generates a deterministic key based on the authorized context. Evaluates if the tool is safe to re-execute based on `READ_ONLY`, `IDEMPOTENT_WRITE`, or `NON_IDEMPOTENT` classifications. It operates strictly *after* authorization.

### 9. Orchestration Controller
Manages hierarchical bounds (`max_depth`, `max_agents`) for multi-agent delegation. It also validates handoff structures when child agents return outputs, preventing injected properties from bypassing state.

### 10. Budget Engine
Enforces explicit resource bounds (tokens, tool calls, execution time, and subagents). Operates on a safe reservation lifecycle (RESERVE, CONSUME, RELEASE) and ensures that child agents can only inherit capability subsets of their parent. Untrusted contexts and payloads cannot override budget assignments.

### 11. State Store
Provides explicitly-owned, concurrent-safe, versioned state persistence for agents. Ensures that sibling agents cannot access each other's data, payloads are scrubbed of secrets, and payload data cannot mutate security boundaries.

### 12. Memory Store
Manages the lifecycle of intentionally retained information (Memory). Enforces explicit provenance, trust levels, and scope boundaries. Distinct from State, Memory acts strictly as retrieved data and can never bypass or modify authorization policies.

### 13. Approval Policy Engine & Registry
Determines if an operation requires explicit human-in-the-loop (HITL) authorization based on a strict risk classification matrix. For privileged or high-risk actions, execution halts until a valid, non-expired approval is recorded by a separate human identity.

### 14. Sandbox
The execution boundary (Docker) for tools that interact with the host (like `run_command`). If the sandbox is unavailable (e.g., Docker is off), any tool requiring it evaluates to `BLOCKED`.

### 15. Trace
A structured, chronological record of events during evaluation:
- `agent_input` (What context was passed to the agent)
- `agent_output` (What the agent decided to do)
- `tool_request` (The specific tool and arguments invoked)
- `policy_decision` (Allow/Deny/Block)
- `execution_requested` / `execution_started` (Idempotency lifecycle)
- `approval_requested` / `approval_approved` / `approval_denied` (HITL lifecycle)
- `tool_result` (The output of the tool)
- `BUDGET_RESERVED` / `BUDGET_CONSUMED` (Resource limits)
- `assertion` (Evaluation checks)

### 16. Assertion
Expected properties of the execution trace, evaluated after the scenario concludes (e.g., `tool_called`, `policy_denied`, `output_contains`).

## Execution Flow

1. **Skill Loader & Verifier** reads and verifies `SKILL.md`.
2. **Context Compiler** builds the context (Task + Skill + Fixture).
3. Context is passed to the **Agent Adapter**.
4. Agent generates a structured tool request or response.
5. **Policy Engine** evaluates the request for dynamic scope authorization.
6. **Idempotency Engine** ensures the request is safe to execute.
7. **Approval Policy Engine** enforces human-in-the-loop sign-off if required.
8. **Orchestration Controller** manages delegation bounds.
9. **Budget Engine** reserves resources prior to execution.
10. If allowed, the request passes to the **Sandbox** or **Execution Engine**.
11. **State / Memory Store** records the result.
12. Result is returned to the Agent, loop continues until task completion.
13. The final **Trace** is evaluated against the Scenario's **Assertions**.
