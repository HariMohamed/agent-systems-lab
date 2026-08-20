# Agent Cost & Resource Budgets

## Verification Status: VERIFIED (Deterministic Control Plane)

## Overview
The BudgetEngine provides a formal security boundary against resource exhaustion, runaway delegation, and infinite token consumption. It sits between Orchestration and Execution.

### Budget Hierarchy
Child agents inherently receive limits bounded by their parent's initial assignments. An explicit initialization phase ensures that a child cannot escalate resources (e.g., `max_tool_calls`, `max_subagents`) beyond what the parent holds, strictly enforcing subset capability rules.

### Reservation Lifecycle
The Budget Engine uses a safe concurrency-aware paradigm:
1. `AVAILABLE`: Budget exists.
2. `RESERVED`: Action authorized; budget decremented *before* execution.
3. `CONSUMED`: Action succeeded; reservation closed.
4. `RELEASED`: Action failed prior to side-effects; budget refunded.
5. `UNKNOWN`: Ambiguous outcome (e.g., timeout). The reservation remains consumed to prevent double-spending in the event the external resource was actually utilized.

### Isolation
Actors maintain strictly isolated budgets. Sibling agents cannot consume or release each other's budgets. A parent cannot access a child's reserved resources. 

### Provider Cost Abstraction
Costs are represented dynamically via `ProviderUsage`, explicitly distinguishing between `EXACT`, `ESTIMATED`, and `UNKNOWN` confidence levels. An unknown cost does not equate to zero cost.

### Threat Mitigation
1. **Adversarial Injection:** Memory, tool outputs, and payloads injecting `{"budget": "unlimited"}` remain strictly inert. The control plane never derives authority from LLM text.
2. **Double Accounting:** Protected by the Reservation ID and state checks (`stale release`, `double reservation`).
3. **Runaway Delegation:** Protected via `max_agents` and `max_subagents`.

### Limitations
Physical CPU and Memory boundaries remain unenforced dynamically because of the lack of a Docker daemon environment. The engine provides logical deterministic boundaries over execution count and agent lifecycle.
