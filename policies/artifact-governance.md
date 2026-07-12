# Repository Artifact Governance

## Mandatory Rules
- **Artifact classification**: All artifacts must be strictly classified into one defined family (skill, workflow, script, tool, tool integration, system design, evaluation, policy, template, reference).
- **Lifecycle assignment**: Non-executables use `incubating` -> `approved`. Executables mandate `quarantined` -> `sandbox` evaluations prior to approval.
- **Provenance & Licensing**: Third-party material must have explicit origin/licensing tracked via `PROVENANCE.yaml`. Avoid fabricating unknown origins. Refer to `policies/licensing-and-provenance.md`.
- **Evaluation requirements**: Artifacts must meet evaluation tiers appropriate for their execution risks. Executables require functional, security, and sandbox tests. Refer to `evaluations/skill-audit-checklist.md` and repository architectural evaluation matrices.
- **Executable isolation**: Executables must not interact with the host system implicitly. No hidden installation, automated privilege escalation, or automatic execution is allowed.
- **Approval criteria**: Approval must never be granted based on popularity or upstream ownership. Evidence-based evaluation determines readiness.
- **Maintenance**: Artifacts are versioned and subject to strict boundary change tracking. Refer to `policies/approved-artifact-maintenance.md`.
- **Discoverability**: All artifacts should be linked in the unified `catalog/artifacts.yaml` to enable discoverability once validated.
- **Deprecation**: Superseded or retired artifacts enter `deprecated` or `archived` states, ensuring usage guidance remains but is clearly flagged against.
