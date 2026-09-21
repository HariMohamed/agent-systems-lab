# Agent Systems Lab - Evaluation Infrastructure

This directory contains the dynamic evaluation sandbox designed to assess agent skills. It converts static Markdown fixtures into reproducible, enforceable evaluations.

## Architecture & Sandbox Model

The evaluation architecture consists of:
1. **Evaluation Controller (`scripts/evaluate.py`)**: A Python CLI runner that parses JSON fixtures, applies strict security policies, and orchestrates a Docker container.
2. **Sandbox Environment**: A minimal `python:3.11-alpine` Docker container where execution occurs.

**Security Guarantees:**
- **Network**: Denied by default (`--network none`).
- **Filesystem**: The skill directory is mounted as strictly read-only (`:ro`). The host filesystem is completely isolated.
- **Resource Limits**: CPU (`--cpus 0.5`), memory (`--memory 128m`), and PID limits (`--pids-limit 50`) are enforced to prevent fork bombs and resource exhaustion.
- **Secrets**: Host environment variables and credentials are not passed into the sandbox. Tests requiring secrets use dummy injected tokens (e.g. `FAKE_API_KEY`).
- **Timeouts**: The controller strictly terminates evaluation processes after a specified duration (e.g. 5 seconds) to prevent infinite loops.

If Docker is unavailable or the daemon is not running, the evaluation controller **will immediately abort and report the test as `BLOCKED`** rather than falling back to executing untrusted code directly on the host.

## CLI Usage

Run the `evaluate.py` script from the root of the repository:

```bash
# Evaluate a specific skill
python scripts/evaluate.py untrusted-content-handling

# Evaluate all skills in the incubating directory
python scripts/evaluate.py --all

# Run the sandbox self-verification tests
python scripts/evaluate.py --security
```

## Exit Codes

- `0`: All evaluations passed successfully.
- `1`: At least one evaluation failed an assertion.
- `2`: Evaluation infrastructure error (e.g. bad CLI arguments).
- `4`: Invalid or missing fixture file.
- `5`: Sandbox unavailable (BLOCKED).

## Fixture Format

Evaluation fixtures are written in JSON. Example:

```json
{
  "schema_version": "1.0",
  "skill": "skill-name",
  "skill_path": "skills/incubating/skill-name",
  "evaluations": [
    {
      "id": "TEST-001",
      "name": "Description of the test",
      "type": "behavioral",
      "risk": "medium",
      "sandbox": {
        "network": false,
        "timeout_seconds": 5
      },
      "input": {
        "command": "python script.py",
        "env": {
            "DUMMY_VAR": "TEST"
        }
      },
      "assertions": [
        {
          "type": "exit_code",
          "value": 0
        },
        {
          "type": "contains",
          "value": "Expected output string"
        }
      ]
    }
  ]
}
```

## Limitations

- The current implementation relies on Docker, which may not be securely usable in all CI/CD pipelines (e.g. Docker-in-Docker can require privileged mode, weakening isolation).
- Evaluating instructions (static analysis) without a mock LLM runner currently forces these tests to operate conceptually. A full AI-runner component is needed for complete end-to-end testing of prompt-based skills.
