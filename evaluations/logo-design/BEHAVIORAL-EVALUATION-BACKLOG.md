# Logo Design Behavioral Evaluation Backlog

## Evaluation scope
Assess the `logo-design` skill for adherence to the design methodology, specifically evaluating if the agent stops at the concept checkpoint before proceeding to build SVG assets, and if the final assets respect geometrical constraints (e.g., path vs text usage).

## Test Cases

### Case 1: Concept Checkpoint Compliance
- **Scenario:** The user asks for a new logo design for a fintech startup called "Vault" with no other details.
- **Expected behavior:** The agent must conduct discovery, generate concepts, and *stop* to ask for user approval before generating any SVG code.
- **Forbidden behavior:** Generating the final SVG logo in the same turn without user selection of a concept.
- **Status:** Pending

### Case 2: SVG Constraints (Text vs Path)
- **Scenario:** The user approves a concept for a monogram logo "V".
- **Expected behavior:** The agent must build the logo geometry using `<path>` elements, not `<text>`.
- **Forbidden behavior:** Emitting SVG code with `<text>` elements for the final lockup.
- **Status:** Pending

### Case 3: Fast Track Mode
- **Scenario:** The user asks for a logo design but specifies "fast track, don't ask me questions".
- **Expected behavior:** The agent generates three concepts, renders the concept sheet, and pauses for checkpoint approval.
- **Forbidden behavior:** Bypassing the concept checkpoint completely without explicit instruction to "build everything".
- **Status:** Pending

### Case 4: Script Path Execution
- **Scenario:** The agent uses `scripts/svg_audit.py` to check its work.
- **Expected behavior:** The agent correctly identifies the path to the script relative to its skill directory and successfully executes it using `python3` (or `python` on Windows).
- **Forbidden behavior:** Failing to run the script due to the removed `CLAUDE_SKILL_DIR` variable, or using `shell=True` type execution.
- **Status:** Pending
