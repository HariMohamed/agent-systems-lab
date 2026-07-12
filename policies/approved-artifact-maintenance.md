# Approved Artifact Maintenance

## Purpose
Establish a unified maintenance, versioning, change-control, and integrity-tracking baseline for all approved repository-native artifacts (workflows, skills, scripts).

## Scope
This policy applies to all repository-native artifacts that have reached the `approved` lifecycle state. It governs how they are versioned, classified for changes, evaluated, and potentially revoked.

## Maintenance states
- `active`: Approved and usable under current documented limitations.
- `maintenance_required`: A non-critical issue or stale evidence requires review, but the artifact is not immediately unsafe.
- `under_review`: Use should be limited while a material change, incident, or safety concern is assessed.
- `deprecated`: Still documented but discouraged for new use.
- `superseded`: Replaced by another named artifact.
- `archived`: Retained for history and no longer active.
- `revoked`: Approval removed because of a verified safety, licensing, provenance, or governance failure. Revocation requires documented evidence and must not happen automatically.

## Versioning
Artifacts use `MAJOR.MINOR.PATCH` versioning:

- **PATCH**: Corrections that do not change behavior (typos, internal links, metadata, clearer wording, provenance references).
- **MINOR**: Backward-compatible behavioral expansion (new activation examples, failure handling, output fields, clarified safety, non-activation boundaries).
- **MAJOR**: Responsibility or safety-boundary changes (new tool execution, authorization rules, state changes, removal of safety constraints, new runtime dependencies).

## Change classifications
- `metadata_only`: Allowed files: front-matter/metadata. Reviewers: single maintainer. Evaluation: none. Lifecycle/Approval: unchanged. Next gate: maintenance.
- `editorial_non_behavioral`: Allowed files: text without changing rules. Reviewers: single maintainer. Evaluation: none. Lifecycle/Approval: unchanged. Next gate: maintenance.
- `behavioral_compatible`: Allowed files: adding boundaries/outputs. Reviewers: two maintainers. Evaluation: targeted re-evaluation. Lifecycle: unchanged. Approval: remains valid after checks pass. Next gate: repository_review.
- `safety_relevant`: Allowed files: safety rules. Reviewers: governance board. Evaluation: full behavioral re-evaluation. Lifecycle: unchanged. Approval: suspended until checks pass. Next gate: repository_review.
- `responsibility_change`: Allowed files: core logic. Reviewers: governance board. Evaluation: full behavioral re-evaluation. Lifecycle: unchanged. Approval: suspended. Next gate: re-promotion.
- `licensing_or_provenance`: Allowed files: PROVENANCE.yaml. Reviewers: licensing owner. Evaluation: none. Lifecycle: unchanged. Approval: suspended if failure. Next gate: maintenance.
- `emergency_security_fix`: Allowed files: minimally required for fix. Reviewers: incident response. Evaluation: affected critical scenarios. Lifecycle: under_review. Approval: suspended. Next gate: re-promotion.

## Review requirements
- **PATCH**: Diff review and integrity record update. No full behavioral re-evaluation unless behavior changed.
- **MINOR**: Targeted behavioral re-evaluation and repository review.
- **MAJOR**: Full behavioral evaluation, full repository review, explicit re-promotion.

## Re-evaluation triggers
Full or targeted re-evaluation must be triggered by changes to:
- activation/non-activation conditions
- authorization/read-only/state-change boundaries
- sensitive-data/prompt-injection rules
- result vocabulary or output contract
- failure handling or platform dependencies
- responsibility/overlap
- provenance/licensing uncertainty
- repository safety policies affecting the artifact
- verified incidents or newly discovered conflicting behavior

Static review is not permanent proof.

## Integrity tracking
Two hashes are required:
- **Full artifact hash**: Hash of the exact file bytes.
- **Normalized behavioral-body hash**: Hash excluding front-matter fields that do not affect operational behavior (e.g., `lifecycle`, `version`, `maintenance_status`).
A change to the normalized-body hash triggers change classification.

## Emergency safety corrections
For verified critical safety defects:
1. Mark maintenance state `under_review`.
2. Record evidence.
3. Restrict use.
4. Apply the minimum correction.
5. Run all affected critical scenarios.
6. Run repository review.
7. Re-promote when required.
8. Record pre/post hashes.
9. Do not hide the original defect.
For an immediate severe issue, approval status becomes `suspended`. History must not be deleted.

## Approval suspension and revocation
Approval must only be revoked for verified safety, licensing, provenance, or governance failures with documented evidence.

## Deprecation
Deprecated artifacts must document:
- reason
- replacement artifact (if any)
- effective version and migration guidance
- last approved version
- review evidence
- whether use remains permitted

## Supersession
Must document identical details as deprecation. Do not silently replace approved artifacts.

## Archival
Retained for history, usage explicitly disallowed.

## Empirical evaluation backlog
Approvals based on static evaluation explicitly acknowledge missing empirical workflow-host execution, cross-model testing, monitoring-platform integration, and production validation. Future targets (e.g., synthetic fixtures, prompt-injection tests) are backlog items and do not block approval unless repository policy changes.

## Evidence retention
All reviews, behavioral evaluation results, and promotion reports must be permanently retained.

## Required reporting
All status transitions and integrity hashes must be recorded in the candidate registry and artifact provenance files.
