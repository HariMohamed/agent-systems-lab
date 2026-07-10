# Skill Audit Checklist

Use this checklist for deterministic review of skills before approval.

## Inventory

- [ ] Skill has a clear directory and `SKILL.md`.
- [ ] Supporting scripts, templates, examples, references, and metadata are listed.
- [ ] Current status is recorded.

## Usefulness

- [ ] Solves a recurring agent workflow problem.
- [ ] Improves quality, safety, speed, consistency, or verification.
- [ ] Is not merely a generic prompt with no operational value.

## Scope

- [ ] Responsibility is narrow and explainable in one sentence.
- [ ] Activation conditions are clear.
- [ ] "When not to use" guidance is present where needed.

## Duplication

- [ ] Overlap with existing skills is identified.
- [ ] High-overlap skills are merged, narrowed, renamed, or rejected.

## Safety

- [ ] No automatic package install, commit, push, merge, deploy, message send, or destructive action.
- [ ] State-changing actions require explicit human approval.
- [ ] Shell permissions are narrow and justified.
- [ ] Secrets and environment variables are not inspected unnecessarily.

## Prompt Injection

- [ ] External content is treated as untrusted data.
- [ ] Retrieved instructions cannot override higher-priority instructions.
- [ ] Suspicious hidden instructions must be reported.

## Portability

- [ ] Platform-specific assumptions are labeled.
- [ ] Tool mappings are accurate for supported agents.
- [ ] Hardcoded paths and OS-specific commands are justified.

## Verification

- [ ] Preconditions are defined.
- [ ] Verification commands or evidence expectations are included.
- [ ] Failure handling is described.
- [ ] Exact verification commands or evidence requirements are identified.
- [ ] Complete command output and exit codes are inspected.
- [ ] Verification directly tests the result being claimed.
- [ ] Partial, skipped, or failed verification is reported honestly.
- [ ] Verification does not authorize unrelated state-changing actions.

## Maintainability

- [ ] Dependencies and versions are clear.
- [ ] Ownership and update expectations are clear.
- [ ] Instructions are concise and ordered.

## Provenance And Licensing

- [ ] Origin is recorded as original, adapted, third-party, or unknown.
- [ ] Upstream source, license, author, version, import date, and modifications are recorded or marked to be verified.
- [ ] Redistribution status is clear.

## Prompt Bloat

- [ ] Repeated policy text is minimized.
- [ ] Long examples are necessary.
- [ ] Repository-level rules are not duplicated unnecessarily.

## Verdict

- [ ] Final verdict is exactly one of KEEP, ADAPT, REJECT, or FUTURE.
- [ ] Required actions are explicit.
