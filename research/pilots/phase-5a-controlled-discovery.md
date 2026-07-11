# Phase 5A — Controlled Discovery Pilot

## Executive verdict
Six potential candidates were identified across three pilot capabilities. However, because immutable revisions (such as specific git tags or content hashes) were not readily verified without executing or downloading potentially unsafe code in this phase, all candidates were placed in the `discovered` state for further review. No candidates were shortlisted. No candidate was imported, installed, executed, approved, published, or deployed during Phase 5A.

## Phase 5A-R correction
The original methodology suffered from an MCP-only query bias, meaning it missed valuable non-MCP workflows, scripts, and evaluation frameworks. Candidate identities were corrected, official alternatives were added, and licenses/immutable revisions were verified where web evidence permitted. The distinction between managed-service integrations (e.g. Datadog) and importable open-source artifacts was clarified. Non-MCP candidates were added to broaden the scope.

## Scope
The pilot focused on discovering reusable agent artifacts in three capabilities:
1. Monitoring and observability workflows
2. Defensive security review
3. Testing strategy and evaluation

## Research method
Web searches were expanded across Tier 1 sources (GitHub) for a broader range of artifact types (skills, workflows, scripts, tool integrations). The queries were broadened beyond MCP servers to include evaluation frameworks and static scanners.

## Source coverage
The search successfully yielded official and community-maintained repositories, including non-MCP workflows and scripts.

## Monitoring and observability candidates
* **datadog-labs-mcp-server**: Official Datadog integration. Marked as `reject` due to being a closed-source managed service.
* **prometheus-mcp-server**: Community implementation for Prometheus metrics.
* **prometheus-mcp**: Official Prometheus MCP server.
* **langfuse**: Non-MCP workflow for agent telemetry and tracing.

## Defensive security candidates
* **studio-mcp**: Official Snyk vulnerability and SCA scanning, replacing the incorrect repository identity.
* **threat-modeling-mcp-server**: AWS Labs project focused on threat modeling.
* **osv-scanner**: Non-MCP dependency scanner from Google.

## Testing and evaluation candidates
* **mcp-playwright**: Community Playwright integration.
* **playwright-mcp**: Official Microsoft Playwright integration.
* **mcp-server-tester**: Evaluation script tool for testing MCP servers themselves.
* **evals**: Official OpenAI non-MCP evaluation framework.

## License findings
Various authoritative licenses were observed, including MIT and Apache-2.0. Standalone notices and precise terms are marked unresolved pending hash/source verification.

## Security findings
Most tool integrations operate with high risk due to external tool execution boundaries (Playwright, Snyk ecosystem tools, `uvx` scripts in AWS threat modeling). Strict isolation and execution boundaries must be defined for any future import.

## Local overlap findings
`mcp-server-tester` and `evals` are complementary to the existing `evaluations/skill-audit-checklist.md`. All others are unique to the repository.

## Compatibility findings
Dependencies range from specific CLI tools (Snyk) to browsers (Playwright) and running platform infrastructure (Datadog, Prometheus).

## Shortlisted candidates
0

## Adaptation candidates
0

## Rejected candidates
2 (`datadog-labs-mcp-server` and `snyk-mcp-server`)

## Future candidates
3 (`langfuse`, `osv-scanner`, `evals`)

## Unknowns
Exact commit hashes and complete security boundaries remain unknown without sandboxed retrieval.

## Pilot metrics (Phase 5A-R)
* candidates considered before registration: 20
* candidates registered: 12
* candidates per capability: 4
* shortlisted: 0
* adapt: 0
* rejected: 2
* future: 3
* needs license review: 0 (All currently default to `needs_security_review` or `future` because license is `unresolved` but security is the more pressing gate)
* needs security review: 7
* Tier 3 leads used: 0
* candidates with immutable revisions: 0
* candidates with verified license evidence: 12 (primary declaration level)
* candidates with content hashes: 0
* candidates blocked by provenance: 12
* candidates blocked by license: 12 (unresolved precise notice requirements)
* candidates blocked by security: 7
* duplicates avoided: 1 (snyk/mcp-server replaced by studio-mcp)

## Phase 5A-P provenance completion
* candidates registered: 12
* candidates with release tags: 4
  * prometheus/prometheus-mcp — v0.18.0
  * snyk/studio-mcp — v1.14.0
  * microsoft/playwright-mcp — v0.0.78
  * steviec/mcp-server-tester — v1.4.1
* candidates with full commit SHAs: 0
* candidates with immutable URLs: 4
* unknown-version count: 8
* candidates still missing immutable revisions: 8
* candidates with standalone licenses: 3
* verified_permitted: 1
* verified_with_conditions: 3
* declaration_only: 6
* unresolved: 2
* not_permitted: 0
* content hashes captured: 0
* hashes still unknown: 12
* needs security review: 6
* needs license review: 0
* future: 4
* reject: 2
* shortlisted: 0
* adapt: 0
* imported: 0
* installed: 0

## Process weaknesses
Identifying immutable revisions via web search alone without API calls or cloning is inefficient. The inability to safely inspect content hashes without downloading blocks candidates from passing the provenance gate to become `shortlisted`.

## Recommended next action
Web research can verify canonical ownership, licenses, releases, tags, and commit-specific revisions. Raw-byte content hashes may require an isolated snapshot or direct raw-file retrieval.
