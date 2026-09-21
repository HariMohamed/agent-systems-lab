---
name: agent-routing
description: Guidelines for determining when and how to delegate tasks to specialized subagents.
---

# Agent Routing and Handoffs

## Overview
Complex tasks should not be handled by a single monolithic agent with an overloaded context window. Instead, use specialized subagents with scoped responsibilities. This skill provides guidelines for routing and handoffs between the primary orchestration agent and its subagents.

## When to Use
- When a task requires a significantly different capability set (e.g., deep research vs. code implementation).
- When context bloat threatens reasoning performance (the "lost in the middle" problem).
- When parallelizing independent subtasks (e.g., fetching data from 3 separate APIs concurrently).

## Core Directives

### 1. Define the Handoff Contract
Before dispatching a subagent, explicitly define:
- **Task:** The specific action the subagent needs to perform.
- **Responsibility:** Exactly what the subagent must accomplish.
- **Constraints:** Specific rules the subagent must follow (e.g., "Do not modify file X", "Use read-only tools").
- **Input/Context:** Only the minimum context required for the subagent's task. Do NOT dump the entire conversation history.
- **Expected Output:** The specific format and criteria for a successful response.
- **Evidence:** What proof the subagent must provide that the task is complete (e.g. tests passing, file paths modified).
- **Failure State:** How the subagent should report failure.

### 1.b Handling Handoff Outcomes
Parent agents must handle various subagent return states:
- **Success:** Verify evidence matches expected output.
- **Failure:** Analyze the failure state; re-dispatch with modified constraints or abort the delegation.
- **Timeout:** Implement bounds. If a subagent times out, treat as failure and fallback.
- **Partial result:** Evaluate if the partial result is sufficient to continue. If not, re-dispatch for the missing portion.
- **Conflicting result:** If multiple subagents return conflicting data, dispatch a verification agent or have the parent resolve.

### Relationship to Existing Skills
This pattern provides foundational routing guidelines that overlap with and compose aspects of older specific skills:
- `subagent-driven-development` (overlaps in multi-agent coding flows)
- `dispatching-parallel-agents` (overlaps in concurrent task delegation)
- `executing-plans` (overlaps in hierarchical task breakdown)
Use this `agent-routing` pattern as the overarching standard.
Subagents should not maintain hidden state. If a subagent performs research, it should write its findings to a persistent artifact (e.g., a markdown file or database) rather than just returning a massive text block in the conversation thread. The parent agent then reads the structured artifact.

### 3. Verification at the Boundary
When a subagent returns control:
- The parent agent MUST verify the subagent's output against the expected handoff contract.
- If the output is deficient, the parent agent should provide specific corrective feedback and re-dispatch, rather than attempting to guess the missing information.

### 4. Specialization over Generalization
Use specific system prompts for subagents based on the role:
- `research_agent`: Read-only, broad internet access, focus on source evaluation.
- `coding_agent`: Local filesystem write access, strict linting rules.
- `security_agent`: Static analysis tools only.

## Failure Modes
- **Circular Dispatching:** Subagents spawning subagents in a loop without converging on a solution. (Mitigation: Enforce depth limits and strict success criteria).
- **Context Loss:** Providing a subagent with a task but omitting the file paths or constraints it needs.
- **Handoff Hallucination:** A subagent claiming it completed a task without providing the verifiable artifact. (Mitigation: Always use `verification-before-completion`).
