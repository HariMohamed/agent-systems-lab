# Repository Artifact Architecture

## Purpose
Define the repository-wide architecture for structuring, classifying, governing, evaluating, and tracking reusable artifacts across broad IT domains.

## Design principles
- Exact responsibility boundaries per artifact type.
- Zero duplication between skills, workflows, scripts, and tools.
- Unified artifact catalog with stable unique IDs.
- Distinct lifecycle routes for executable vs. non-executable artifacts.
- Mandatory provenance, execution-risk classification, and evaluation requirements.

## Supported artifact types
1. **Skill**: Reusable instruction set altering reasoning/behavior (not executable code).
2. **Workflow**: Multi-stage operational process coordinating reasoning or tools.
3. **Script**: Bounded executable automation stored as source code.
4. **Tool**: Maintained executable capability with stable interfaces.
5. **Tool integration**: Adapter/configuration connecting agents to external capabilities.
6. **System design**: Reusable architecture pattern detailing requirements and trade-offs.
7. **Evaluation**: Artifact used to test/assess another artifact.
8. **Policy**: Mandatory repository governance or safety rule.
9. **Template**: Reusable structure for creating another artifact.
10. **Reference**: Curated context and ecosystem knowledge.

## Artifact boundaries
- **Skill vs. Workflow**: Skill is behavioral capability; workflow is staged operational process.
- **Workflow vs. Script**: Workflow describes a controlled process; script executes automation.
- **Script vs. Tool**: Script is a small bounded unit; tool is a maintained multi-component utility.
- **Tool vs. Tool integration**: Tool is repository-maintained; integration connects to external systems.
- **System design vs. Workflow**: System design provides architecture; workflow provides operational process.
- **Evaluation vs. Script**: Evaluation defines test intent and verdict; scripts may just be helpers.

## Directory architecture
The repository target structure adopts artifact families, and within those families, lifecycle subdirectories are used where applicable. Workflows continue using artifact-specific directories with lifecycle tracking in metadata.
```text
skills/ (approved, incubating, rejected, archived, templates)
workflows/ (<artifact-name>/)
scripts/ (approved, incubating, rejected, archived, templates)
tools/ (approved, incubating, rejected, archived, templates)
tool-integrations/ (approved, incubating, rejected, archived, templates)
system-design/ (approved, incubating, rejected, archived, templates)
evaluations/
policies/
templates/
references/
research/
catalog/
```

## Lifecycle routes
**Non-executable artifacts (skills, workflows, system-design, references):**
`discovered -> incubating -> evaluated -> repository_reviewed -> approved -> maintained`

**Executable artifacts (scripts, tools, tool-integrations):**
`discovered -> quarantined -> static_review -> dependency_review -> security_review -> sandbox_test -> behavioral_or_functional_evaluation -> repository_review -> approved -> maintained`

## Execution-risk model
Artifacts have one primary execution-risk classification:
- `non_executable`
- `local_read_only`
- `local_state_changing`
- `external_read_only`
- `external_state_changing`
- `privileged`
- `destructive`
- `unknown`

## Trust and origin model
- Origins: `repository_original`, `adapted_third_party`, `third_party_unmodified`, `external_reference`, `generated_repository_artifact`.
- Confidence: `verified_immutable`, `verified_mutable`, `maintainer_declared`, `community_reported`, `unresolved`.

## Unified catalog
A unified YAML catalog mapping stable unique identifiers (e.g., SKILL-0001, WORKFLOW-0001) to explicit source files. Sequential IDs are used to avoid naming collisions and to separate conceptual identity from filename details.

## Artifact identifiers
Format: `FAMILY-0000` (e.g., `SKILL-0001`, `WORKFLOW-0001`, `SCRIPT-0001`). Stable IDs ensure resilience against renamed files.

## Domain taxonomy
Broad IT domains defined for artifact alignment, extending from `software-engineering`, `devops`, `cybersecurity` to `ui-ux`, `ai-and-model-engineering`, etc.

## Capability coverage
Artifact domains are tracked through statuses: `none`, `research_only`, `candidate_identified`, `incubating`, `approved`, `maintenance_required`.

## Dependency relationships
Types: `uses`, `extends`, `evaluates`, `governed_by`, `inspired_by`, `integrates_with`, `supersedes`, `conflicts_with`. Prevents hidden installations.

## Evaluation matrix
- **Skill/Workflow**: static + behavioral + repository review.
- **Script**: static + functional + security + sandbox + repository review.
- **Tool**: architecture + functional + security + sandbox + repository review.
- **Tool integration**: permissions + security + sandbox + behavioral + repository review.
- **System design**: architecture review + scenario analysis.
- **Policy/Template/Evaluation**: governance/schema/meta-evaluation.

## Naming conventions
- Lowercase kebab-case directory names.
- Canonical uppercase files (e.g., `SKILL.md`, `WORKFLOW.md`).
- Domain responsibility clear from names (no generic `utils` or `helper`).

## Scripts requirements
Clear purpose, input/output, safe defaults, no silent installs, dry-run required for state changes, path validation, timeouts, exit codes, and explicit execution-risk tracking.

## Tools requirements
Architecture definitions, trust boundaries, configuration schemas, threat models, uninstallation behavior, comprehensive tests, and maintenance ownership.

## Tool-integration requirements
Explicit permissions (read vs state-change), data retention behavior, allow/deny lists, and prompt-injection threat assessment.

## Existing repository classification
Existing structure contains actual artifacts, research notes, policies, checklists, and templates. These are mapped into the catalog without incorrectly labeling research as tools.

## Migration approach
Existing approved artifacts are cataloged in-place. No moving of files required to avoid churn.

## Anti-patterns
- Claiming empirical validation for statically-evaluated artifacts.
- Fabricating unknown origins.
- Merging scripts into workflows silently.

## Recommendation
Approve and adopt the repository artifact architecture natively.
