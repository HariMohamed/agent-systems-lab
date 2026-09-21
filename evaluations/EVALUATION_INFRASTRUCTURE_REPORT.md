# Evaluation Infrastructure Final Report

## Architecture
The evaluation framework is designed as a minimal, CLI-driven Python orchestrator (`scripts/evaluate.py`) that reads standardized JSON fixture files, spins up isolated Docker sandboxes, executes test commands, and evaluates deterministic assertions against the standard output, standard error, and exit codes.

## Threat Model
Evaluated skills and agent interactions represent untrusted external code. Our threat model focuses on containing executing code from altering the host filesystem, exfiltrating data via the network, reading local credentials (e.g. `~/.aws/credentials`), or exhausting host resources. The controller acts as a trusted entity that enforces isolation at the boundary. See `THREAT_MODEL.md` for a complete breakdown.

## Sandbox Choice
We chose **Docker (Linux containers via WSL/Hyper-V on Windows)** as the most robust sandbox realistically supported by the repository's target environment.
- The container uses a minimal `python:3.11-alpine` image to reduce the attack surface.
- The `--network none` flag completely isolates the container from the internet and local network.
- The host filesystem is protected by mounting the skill directory strictly as `read-only` (`:ro`).
- If Docker is unavailable or misconfigured, the controller explicitly marks the evaluation as `BLOCKED` and refuses to fall back to unsafe local execution.

## Fixture Format
Fixtures have been standardized into machine-readable `eval.json` files alongside existing human-readable markdown. The schema explicitly declares required sandbox policies (like `network` and `timeout_seconds`), injected environment variables, and the specific command to run.

## Assertion Model
Assertions are decoupled from fuzzy natural language. Supported types include:
- `contains` / `not_contains` (string matching on stdout/stderr)
- `exit_code` (exact matching on the process return code)
- `network_denied` (heuristics for catching curl/wget failures)

## CLI
The infrastructure is driven by a lightweight, dependency-free Python script (`evaluate.py`), utilizing the built-in `json`, `subprocess`, and `argparse` modules.
- Run a single skill: `python scripts/evaluate.py untrusted-content-handling`
- Run all skills: `python scripts/evaluate.py --all`
- Run security self-checks: `python scripts/evaluate.py --security`

## Security Guarantees
- The evaluated code cannot access real host environment variables.
- The evaluated code cannot modify files in the repository.
- The evaluated code cannot establish external connections (unless explicitly opted-in).
- CPU (`0.5`), RAM (`128m`), and process (`50 PIDs`) limits prevent resource starvation attacks like fork bombs.
- A strict execution timeout ensures runaway processes are killed.

## Security Limitations
- Docker provides strong but imperfect isolation. Kernel exploits (container escapes) remain a residual risk.
- Since LLM skills consist largely of natural language instructions rather than executable code, they currently require an external mock runner to effectively test execution paths.

## Tests
- Added executable JSON fixtures for all 8 `skill-security-audit` test scenarios.
- Added executable JSON fixtures for all 6 `untrusted-content-handling` behavioral scenarios.
- Added executable JSON fixtures for all 9 `agent-routing` behavioral scenarios.
- Added a `sandbox_tests.json` file designed specifically to attempt malicious breakouts (exfiltration, writes, fork bombs) to prove the sandbox limits function as intended.

## CI Integration
Since this environment lacks an existing `.github` CI directory, we have ensured the `evaluate.py` script returns deterministic exit codes (e.g., `0` for pass, `1` for failure, `5` for sandbox blocked). This script is ready to be embedded into any CI system that supports a nested Docker runtime.

## Performance
The Python orchestrator relies on Docker caching. The `python:3.11-alpine` image pulls rapidly and has minimal overhead. Because network operations are blocked and timeouts are strictly enforced (typically < 5s), the entire evaluation suite executes very quickly.

## Known Gaps
There is currently no Agent/LLM Execution Engine built into the repository to run the agent skills. The evaluation fixtures are primed and ready for commands (e.g., `python mock_evaluator.py`), but these commands will fail safely or be blocked until an LLM harness is built.

## Next P0
The immediate next P0 action is to build the actual LLM testing harness or mock engine that can interpret `SKILL.md` text and produce the structured outputs expected by the `eval.json` assertions.
