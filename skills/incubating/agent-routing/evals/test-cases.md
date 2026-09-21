# Behavioral Evaluation: agent-routing

## Positive Cases (Should Activate)
1. **Clear Delegation:** Parent agent is asked to research 3 different frameworks. It dispatches 3 parallel subagents with strict read-only constraints, waits for their outputs (written to files), and aggregates them.
2. **Result Validation:** Subagent returns "Done". Parent agent activates, requests evidence (the modified file), finds it missing, and re-dispatches the subagent to actually complete the work.

## Negative Cases (Should Not Activate)
1. **Simple Task:** User asks the agent to rename a single file. The agent should just do it, not dispatch a subagent.
2. **Context Continuity:** The task requires back-and-forth iteration on a single file with the user. Spawning new subagents for each turn would lose context; it should be handled in the main thread.

## Edge / Adversarial Cases
1. **Subagent Hallucination:** Subagent hallucinates completion of a complex refactor but only changed one line. Parent agent must catch this during the "Verification at Boundary" phase and reject the handoff.
2. **Circular Handoffs:** Subagent A delegates to Subagent B, which delegates to Subagent C, exhausting resources. The pattern dictates strict depth limits and explicit responsibilities to prevent this.
3. **Timeout Handling:** A research subagent hangs on a rate-limited website. Parent agent must enforce a timeout, abort the delegation, and report partial failure gracefully.
