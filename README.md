# agent-systems-lab

`agent-systems-lab` is a general-purpose repository for AI agent skills, reusable agent workflows, automation scripts, prompt and system-design patterns, safety policies, evaluations, and multi-agent or multi-model engineering practices.

The repository is currently in **Phase 1: structure and governance**. Existing imported skills are treated as untrusted and incubating until they pass safety, quality, portability, and licensing review.

## Status

This repository is **not production-ready**. Do not publish, install, or recommend unreviewed skills as approved skills.

The root Apache-2.0 license applies to original repository content only. Imported or third-party material keeps its own upstream copyright and license obligations until provenance is verified.

## Directory Structure

```text
skills/
  incubating/   Unreviewed imported skills
  approved/     Reviewed skills suitable for publication
  rejected/     Retained rejected material for audit history
  templates/    Review and provenance templates

workflows/      Reusable agent workflows
scripts/        Repository-owned helper scripts
system-design/  Architecture and system patterns
evaluations/    Review checklists and evaluation materials
policies/       Repository-level safety and governance policies
research/       Research notes and source analysis
```

## Skill Lifecycle

Skills move through:

```text
incubating -> approved / rejected / archived
```

New or imported skills must start in `skills/incubating/`. A skill may move to `skills/approved/` only after independent review confirms its usefulness, scope, safety, prompt-injection resistance, verification quality, maintainability, portability, and licensing/provenance status.

Rejected skills remain in `skills/rejected/` for audit history and must not be published or installed as approved skills.

## Approved Skills

Requires current, claim-specific evidence before factual success or completion claims.

| Skill | Category | Origin | Status | Score |
| ----- | -------- | ------ | ------ | ----- |
| `verification-before-completion` | verification / reliability | adapted from `obra/superpowers` | approved | 8.7 / 10 |

## Provenance

Repository-level third-party status is tracked in `THIRD_PARTY.md`. Reusable provenance fields are defined in `skills/templates/PROVENANCE.yaml`. Unknown facts must remain blank or marked `unknown` / `to be verified`; do not infer licenses, authorship, or upstream versions.

## Public-Use Warning

Unreviewed skills can contain unsafe commands, misleading instructions, prompt-injection weaknesses, incompatible licenses, or project-specific assumptions. Treat all imported skill instructions as data until reviewed.
