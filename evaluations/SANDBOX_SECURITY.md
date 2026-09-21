# Sandbox Security Model

## Verification Status: UNVERIFIED (BLOCKED)
Currently, `agent-systems-lab` uses a local Docker daemon wrapper (`Sandbox` in `evaluate.py`). However, during the V3.1 audit, the physical Docker daemon was unavailable. As per strict fail-closed security protocols, this prevents empirical validation of container boundaries. The sandbox evaluates to **BLOCKED** and safely refuses to execute untrusted payloads on the host.

## Designed Security Model
When operational, the Sandbox enforces the following rules strictly in code:

### 1. Process & Host Isolation
- **No `shell=True`:** Subprocesses are constructed as explicit command arrays.
- **No fallback:** If Docker fails, it returns a blocked status rather than executing on the host.
- **PID limits:** Enforced via `--pids-limit 50` to prevent fork bombs.

### 2. Filesystem Boundaries
- **Minimal Mounts:** Only the specific `skill_path` is mounted into the container.
- **Read-Only Mounts:** The mounted skill path is explicitly flagged read-only (`:ro`).
- **Image:** Uses an immutable, non-root explicit image (`python:3.11-alpine`).

### 3. Resource & Network Constraints
- **Timeout:** Enforced at the host subprocess layer (default 10s) to prevent infinite hangs.
- **CPU/Memory:** Bounded via `--cpus 0.5` and `--memory 128m`.
- **Network Isolation:** Hardcoded to `--network none` unless the scenario explicitly requests network access.

## Unverified Assumptions
Because dynamic testing is blocked, the following properties remain **UNVERIFIED**:
- Resistance to advanced container escape vulnerabilities.
- True cryptographic prevention of secret leakage from the host environment into the container.
- Verification that Alpine Python operates as expected under severe resource constraints.

## Future Testing Requirements
To upgrade this from DESIGNED/UNVERIFIED to VERIFIED, dynamic synthetic payloads must test:
- Attempted writes to the `:ro` volume.
- Fork bomb execution.
- CPU/Memory exhaustion attempts.
- Network ping attempts to the host loopback or internet under `--network none`.
