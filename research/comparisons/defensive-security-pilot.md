# Candidate Comparison

## Capability
Defensive security review

## Candidates
* studio-mcp v1.14.0 (Official Snyk integration)
* threat-modeling-mcp-server (AWS threat modeling)
* osv-scanner (Non-MCP dependency scanner)

## Comparison scope
Evaluating automated and integrated threat modeling and dependency scanning capabilities.

## Authoritative sources
* snyk/studio-mcp
* awslabs/threat-modeling-mcp-server
* google/osv-scanner

## License comparison
All declare Apache-2.0.

## Security comparison
Snyk Studio MCP introduces risk of executing ecosystem build tools (Maven, Gradle) within the agent environment. AWS Threat Modeling requires `uvx` execution and writes local files. OSV-Scanner is a robust static analysis script.

## Responsibility and activation
Threat modeling (AWS), vulnerability/SCA scanning (Snyk, OSV-Scanner).

## Inputs and outputs
Source code, dependencies, cloud templates.

## Side effects
File writes (.threatmodel), external tool execution, API calls.

## Platform compatibility
Generic execution, but Snyk needs CLI authentication. AWS requires Python ecosystem.

## Maintenance
All are from high-quality, official organizations (Google, AWS, Snyk).

## Local overlap
None.

## Evaluation evidence
Not deeply evaluated.

## Adaptation burden
Snyk and AWS need strict sandboxing of execution boundaries.

## Decision
* Outcome: keep_both_complementary
* Preferred: CAND-0009 — studio-mcp and CAND-0004 — aws-mcp-threat-modeling
* Compared against: N/A
* Scope: future source-snapshot priority only

* Outcome: defer
* Deferred: CAND-0010 — osv-scanner
* Scope: future evaluation consideration

## Unknowns
Content hashes, precise dependency chains, exact license notice terms.

## Reviewer
Agent

| Feature | studio-mcp | threat-modeling | osv-scanner |
| ------- | ---------- | --------------- | ----------- |
| License | Apache-2.0 | Apache-2.0 | Apache-2.0 |
| Security Risk | High | High | Medium |
| Overlap | Unique | Unique | Unique |
| Decision | needs_security_review | needs_security_review | future |
