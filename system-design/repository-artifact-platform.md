# Repository Artifact Platform

## Status
proposed

## Context
As `agent-systems-lab` grows beyond simple scripts and agent skills into workflows, tools, and system-design methodologies, an unstructured repository lacks governance to prevent executable risks, artifact duplication, and untracked lifecycles. We require a robust artifact architecture to organize, safely evaluate, and systematically maintain artifacts across all IT domains.

## Goals
- Support diverse IT artifacts safely (skills, workflows, scripts, tools, integrations, designs, policies, evaluations).
- Prevent duplication.
- Enforce separated lifecycles for executable versus non-executable artifacts.
- Require rigorous execution-risk classification.
- Unify cross-domain indexing via a catalog.

## Non-goals
- We will not automatically execute third-party components during classification.
- We will not create massive monolithic tooling.
- We will not migrate existing approved artifacts in disruptive ways.

## Artifact model
- **Non-executable**: skills, workflows, system-designs, references, policies, templates, evaluations.
- **Executable**: scripts, tools, tool integrations.

## Repository components
- **Catalog**: Unified YAML registry of unique artifact IDs mapped to files.
- **Directories**: Subdivided by artifact family and lifecycle statuses where appropriate.
- **Policies**: Constraints dictating maintenance and evaluation procedures.

## Catalog data flow
Catalog acts as an index of `location` to artifact canonical files. It is updated upon artifact approval or maintenance status shifts.

## Lifecycle data flow
- Non-executables bypass quarantines and sandbox testing.
- Executables must traverse deep functional and security isolation paths.

## Trust boundaries
Artifacts are isolated conceptually. Trust is declared via origin tracking and behavioral evaluation. Dependencies do not auto-install.

## Execution boundaries
Clearly distinct read-only and state-changing models defined per artifact catalog entry. Execution risks map directly to test expectations.

## Evaluation boundaries
Static analyses are decoupled from empirical execution. Cross-model evaluation is retained as backlog infrastructure.

## Maintenance model
Artifacts employ the standard `approved-artifact-maintenance.md` constraints (SemVer mapping to behavioral thresholds).

## Extension points
The catalog and registry models easily extend to new artifact families.

## Failure modes
- Bloated catalog without artifact implementations (mitigated by strict registration rules).
- Skipping sandbox tests for executables (mitigated by pipeline gates).

## Trade-offs
- **Sequential IDs vs Slugs**: Sequential IDs (`SKILL-0001`) lose descriptive nature but prevent collisions, rename friction, and path breakages. We chose sequential IDs to decouple identity from taxonomy.

## Alternatives considered
- Leaving all artifacts in a flat `skills/` directory: Rejected due to execution boundary ambiguity.
- Dynamic catalog generation: Rejected due to inability to audit provenance strictly across branches.

## Decision
Adopt the multi-family artifact architecture and catalog approach.

## Consequences
- The repository becomes capable of safely housing operational automation alongside agent skills.
- The barrier for introducing an executable artifact becomes correctly and rigidly high.
