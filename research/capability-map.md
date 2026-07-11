# Capability Map

## Executive summary
The repository currently holds 1 approved skill, 15 incubating skills, and 3 rejected placeholders. While there is a concentration of capabilities in agent orchestration and software development (especially originating from `obra/superpowers`), the repository completely lacks artifacts in `workflows/`, `scripts/`, `system-design/`, and `evaluations/`. Critical foundational blockers exist, such as the need for standard evaluation harnesses, candidate registries, and security triage protocols, which must be resolved before proceeding with broad external discovery.

## Existing repository inventory

### Approved skills
- **verification-before-completion**
  - Path: `skills/approved/verification-before-completion/`
  - Lifecycle: approved
  - Origin: adapted from `obra/superpowers`
  - Artifact type: skill
  - Primary domain: Testing and quality
  - Secondary domains: Software development
  - Capability: verification-before-completion
  - Safety risk: low
  - Execution risk: read-only
  - Compatibility: generic
  - Duplication observations: unique
  - Current audit status: approved (8.7/10 score)
  - Discovery relevance: High; core safety and quality gate.

### Incubating skills
- **brainstorming**: `skills/incubating/brainstorming/` | skill | Software development (brainstorming) | high state-change risk | probable Superpowers | overlapping
- **dispatching-parallel-agents**: `skills/incubating/dispatching-parallel-agents/` | skill | Agent foundations (multi-agent orchestration) | medium risk | probable Superpowers | complementary
- **executing-plans**: `skills/incubating/executing-plans/` | skill | Agent foundations (planning) | medium risk | probable Superpowers | overlapping with subagent workflows
- **find-skills**: `skills/incubating/find-skills/` | skill | Research and knowledge work (deep research) | high risk | adapted from `vercel-labs/skills` | unique | PENDING_BEHAVIORAL_EVALUATION
- **finishing-a-development-branch**: `skills/incubating/finishing-a-development-branch/` | skill | DevOps (release engineering) | high risk (commits/merges) | probable Superpowers | unique
- **receiving-code-review**: `skills/incubating/receiving-code-review/` | skill | Software development (code review) | medium risk | probable Superpowers | complementary
- **requesting-code-review**: `skills/incubating/requesting-code-review/` | skill | Software development (code review) | medium risk | probable Superpowers | complementary
- **subagent-driven-development**: `skills/incubating/subagent-driven-development/` | skill | Agent foundations (multi-agent orchestration) | high risk | probable Superpowers | overlapping
- **systematic-debugging**: `skills/incubating/systematic-debugging/` | skill | Software development (debugging) | medium risk | probable Superpowers | complementary
- **test-driven-development**: `skills/incubating/test-driven-development/` | skill | Testing and quality (unit testing) | medium risk | probable Superpowers | overlapping
- **using-git-worktrees**: `skills/incubating/using-git-worktrees/` | skill | DevOps (environment management) | high risk | probable Superpowers | unique
- **using-superpowers**: `skills/incubating/using-superpowers/` | skill | Agent foundations (meta-skill) | high risk (dispatcher) | probable Superpowers | unique
- **vercel-react-best-practices**: `skills/incubating/vercel-react-best-practices/` | skill | Software development (frontend development) | medium risk | probable Vercel | unique
- **writing-plans**: `skills/incubating/writing-plans/` | skill | Software development (implementation planning) | medium risk | probable Superpowers | complementary
- **writing-skills**: `skills/incubating/writing-skills/` | skill | Agent foundations (agent skill writing) | high risk | mixed Superpowers/Anthropic | complementary

### Rejected placeholders
- **database-query-profiler**: `skills/rejected/database-query-profiler/`
- **performance-lighthouse-runner**: `skills/rejected/performance-lighthouse-runner/`
- **tailwind-class-optimizer**: `skills/rejected/tailwind-class-optimizer/`

### Other artifacts
workflows:
  No operational workflow artifacts yet.

scripts:
  No reusable executable scripts yet.

system-design:
  No reusable system-design artifacts yet.

evaluations:
  Repository-level skill audit checklist exists.
  Skill-local evaluation reports exist for reviewed skills.
  Reusable behavioral evaluation templates, automated harnesses, and cross-agent regression suites are still missing.

templates:
  PROVENANCE.yaml and REVIEW.md templates exist.

policies:
  Safety, licensing/provenance, and prompt-injection policies exist.

## Domain coverage
- **Agent foundations**: covered-incubating
- **Software development**: covered-incubating
- **Testing and quality**: covered-approved
- **DevOps and platform engineering**: covered-incubating
- **Monitoring and reliability**: missing
- **Cybersecurity and defensive security**: missing
- **Architecture and system design**: missing
- **Databases and data systems**: rejected-placeholder
- **UI/UX and product design**: rejected-placeholder
- **Crawling, scraping, and browser automation**: missing
- **AI and model engineering**: missing
- **Research and knowledge work**: covered-incubating

## Approved coverage
The only currently approved capability is `verification-before-completion`, which provides foundational quality assurance prior to task termination.

## Incubating coverage
Heavy coverage of code review, debugging, test-driven development, and subagent orchestration. The incubating coverage largely reflects the `obra/superpowers` implementation lifecycle.

## Missing capabilities
- **DevOps**: CI/CD integration, observability, containerization workflows.
- **Security**: SAST/DAST skills, secure coding, secrets detection, dependency security.
- **Architecture**: Distributed system design patterns, database observability, API architecture.
- **Frontend**: Accessibility testing, frontend polish, visual regression.
- **Data/Web**: Safe crawling workflows, change detection.

## Overlaps and duplication
- `executing-plans`, `subagent-driven-development`, `writing-plans`, and `finishing-a-development-branch` present heavy circular activation and overlap.
- `requesting-code-review` and `receiving-code-review` overlap in code-review flow management.
- `test-driven-development`, `systematic-debugging`, and `writing-skills` share large rationalization prevention structures that could be refactored into overarching repository policies.
- Many scripts embedded inside these skills could be centralized in the `scripts/` directory.

## Artifact-type gaps
Currently, the entire repository is categorized primarily as `skill`.
While there are existing `policy`, `template`, and `evaluation` (checklist/documentation) artifacts, there are zero approved or incubating operational `workflow`, `script`, `system-design`, or `tool-integration` artifacts, and no reusable automated evaluation infrastructure.

## Evaluation gaps
Evaluation coverage:
- skill audit checklist: existing
- skill-local scenario evaluations: existing for selected reviewed skills
- reusable behavioral evaluation template: missing
- automated evaluation runner: missing
- cross-agent empirical test harness: missing

## P0 blockers
- candidate registry
- provenance capture
- license verification
- security screening
- duplication detection
- behavioral evaluation templates
- safe import workflow
- immutable source capture
- repository indexing

## P1 opportunities
- monitoring and observability workflows
- DevOps and CI/CD review
- defensive security review
- testing strategy
- architecture review
- system-design evaluation
- database performance analysis
- frontend/UI polish
- accessibility review
- crawling pipeline safety
- incident response
- release readiness

## P2 future areas
- chaos engineering
- advanced model routing
- multi-region architecture
- formal methods
- advanced red-team evaluation
- niche framework skills

## Recommended discovery waves
- **Wave 0 — repository infrastructure**: Tools and templates for candidate ingestion and repository hygiene.
- **Wave 1 — core development quality**: Systematic debugging, code review, documentation, verification.
- **Wave 2 — DevOps and reliability**: CI/CD, deployment review, SLI/SLO, incident response.
- **Wave 3 — security**: Secure coding, supply-chain security, secrets handling, threat modeling.
- **Wave 4 — architecture and data**: Distributed systems, DBs, caching, multi-tenancy.
- **Wave 5 — UI/UX and frontend quality**: Accessibility, visual regression, frontend polish.
- **Wave 6 — crawling and research**: Safe public crawling, deep research, fixtures.
- **Wave 7 — advanced agent engineering**: Model routing, memory, context engineering, evaluation.
