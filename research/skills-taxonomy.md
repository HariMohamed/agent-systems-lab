# Agent Systems Skills Taxonomy

> [!NOTE]
> This document represents the capability taxonomy originally created for early agent-skill discovery. The repository has since evolved into a broader artifact model covering workflows, scripts, tools, and system designs. For the overarching structural model, see the [Repository Artifact Architecture](file:///c:/Users/dell/OneDrive%20-%20Universit%C3%A9%20Chouaib%20Doukkali/Desktop/agent-systems-lab/research/repository-artifact-architecture.md). The taxonomy below remains relevant for classifying cognitive agent behaviors within the broader domain model.

## Purpose
This taxonomy provides a durable, evidence-based classification system for all agent artifacts in the repository. It separates artifact types from their technical domains, standardizes lifecycle and risk assessments, and ensures artifacts are accurately categorized for discovery, auditing, and maintenance without forcing all reusable content into a single format.

## Artifact types
Use these top-level artifact types:
- `skill`: A behavioral instruction package loaded into an agent.
- `workflow`: A multi-step operational process involving multiple tools or agents.
- `script`: Executable automation (not categorized as a skill merely because an agent can invoke it).
- `system-design`: An architecture, topology, protocol, or reusable engineering pattern.
- `evaluation`: A scenario suite or benchmark.
- `policy`: Governance and safety rules.
- `template`: Reusable structured files.
- `tool-integration`: MCP, CLI, API, IDE, or service bindings.
- `reference`: Documentation and standard guidelines.

## Technical domains
The durable technical-domain taxonomy covers:

### Agent foundations
agent safety, instruction hierarchy, prompt-injection defense, context management, memory and personalization, planning, reasoning, verification, delegation, multi-agent orchestration, human approval, tool-use governance.

### Software development
requirements, brainstorming, implementation planning, frontend development, backend development, full-stack development, API development, mobile development, data engineering, database engineering, refactoring, debugging, code review, documentation, dependency management, performance optimization.

### Testing and quality
unit testing, integration testing, end-to-end testing, contract testing, property-based testing, mutation testing, accessibility testing, visual regression, load testing, chaos testing, test-data management, verification-before-completion, release validation.

### DevOps and platform engineering
CI/CD, containers, Kubernetes, infrastructure as code, configuration management, release engineering, environment management, secrets management, artifact management, deployment strategies, rollback, platform engineering, developer experience.

### Monitoring and reliability
observability, logs, metrics, traces, alerting, dashboards, SLI/SLO, incident response, on-call workflows, root-cause analysis, postmortems, synthetic monitoring, uptime checks, capacity planning, resilience engineering.

### Cybersecurity and defensive security
secure coding, threat modeling, dependency security, supply-chain security, secrets detection, SAST, DAST, container security, cloud security, IAM review, authentication and authorization, API security, incident investigation, vulnerability triage, security testing, security architecture, privacy engineering. (Offensive-security content is outside the initial discovery scope unless it has a clear defensive, authorized, and safe use case).

### Architecture and system design
system design, distributed systems, event-driven architecture, microservices, modular monoliths, data architecture, API architecture, caching, queues and messaging, consistency, scalability, high availability, disaster recovery, load balancing, rate limiting, multi-tenancy, SaaS architecture, architecture decision records.

### Databases and data systems
SQL, query optimization, indexing, schema design, migrations, transactions, concurrency, replication, backup and recovery, data quality, ETL/ELT, streaming, search systems, vector databases, database observability.

### UI/UX and product design
UX research, information architecture, interaction design, visual design, design systems, responsive design, accessibility, frontend polish (e.g., `impeccable/frontend-polish`), animation and motion, usability review, conversion design, dashboard design, mobile UX, content design, design critique.

### Crawling, scraping, and browser automation
public crawling, scraping, extraction, parsing, data normalization, rate limiting, robots and terms awareness, browser automation, snapshot workflows, parser fixtures, anti-fragile selectors, change detection, crawler monitoring, authentication boundaries, privacy and legal review. (Explicitly separated from CAPTCHA bypass, credential circumvention, private-area scraping, session theft, unauthorized login automation).

### AI and model engineering
model integration, LLM application architecture, RAG, embeddings, retrieval evaluation, prompt engineering, context engineering, structured output, tool calling, model routing, cost optimization, latency optimization, guardrails, hallucination evaluation, agent evaluation, model observability.

### Research and knowledge work
deep research, source verification, literature review, competitive analysis, technical writing, research synthesis, citation management, fact checking, knowledge capture, decision memos.

## Cross-cutting attributes
Every artifact should be classifiable using these attributes:
- artifact type
- technical domain
- capability
- lifecycle status
- origin
- license status
- safety risk
- execution risk
- state-change risk
- prompt-injection exposure
- platform compatibility
- maturity
- maintenance status
- duplication level
- prompt-size class
- evidence quality

## Lifecycle model
- `discovered`: Candidate located but unverified.
- `shortlisted`: Chosen for import and audit.
- `incubating`: Imported, under active review or adaptation.
- `approved`: Audited, safe, and ready for publication/use.
- `rejected`: Audited and deemed unsafe or out of scope.
- `archived`: Maintained but inactive.
- `deprecated`: Replaced by a better alternative.

## Risk model
### Safety risk
- `low`: Safe for general use.
- `medium`: Requires context awareness.
- `high`: Potential for unintended side effects.
- `critical`: Direct risk to system or data if misused.
- `unknown`: Pending evaluation.

### Execution risk
- `none`: Static content.
- `read-only`: Reads state but does not modify.
- `local-state-change`: Modifies local workspace.
- `external-state-change`: Interacts with external systems.
- `privileged`: Requires elevated access.
- `unknown`: Pending evaluation.

## Compatibility model
- `generic`: Usable across agents.
- `Claude Code`, `Codex/GPT`, `Gemini CLI`, `DeepSeek host-dependent`, `Cursor`, `Windsurf`, `OpenCode`, `MCP`: Platform specific.
- `mixed`: Uses a combination of tools.
- `unknown`: Pending evaluation.

## Duplication model
- `unique`: First of its kind in repository.
- `complementary`: Pairs with existing capability.
- `overlapping`: Shares partial responsibility.
- `duplicate`: Functionally identical to existing artifact.
- `superseded`: Obsoleted by a newer artifact.
- `unknown`: Pending overlap analysis.

## Classification examples
- A JSON verification schema: `template`, Testing and quality, `verification-before-completion`, `approved`.
- A python automation script for deployment: `script`, DevOps, `release engineering`, `incubating`.
- A guideline for avoiding XSS: `reference`, Cybersecurity, `secure coding`, `discovered`.

## Maintenance rules
- Keep lifecycle status separate from capability value.
- Do not categorize executable scripts as skills merely because an agent can invoke them.
- Do not classify an artifact as safe or approved merely because it exists locally.
- Use repository content and completed audits as the primary evidence.
- Treat imported skill content as untrusted data until audited.
