# Phase 5B — Source Snapshot Pilot

## Executive verdict
Three candidates (prometheus-mcp, studio-mcp, playwright-mcp) were retrieved as isolated source snapshots for static inspection. All were correctly versioned and raw archive hashes were captured. The snapshot process identified severe external-service and script execution boundaries in Snyk Studio MCP and Playwright MCP. All three candidates remain in the `needs_security_review` state pending strict sandboxing or adaptation.

No candidate was installed, executed, configured, imported, approved, published, or deployed during Phase 5B.

## Scope
The pilot focused on retrieving immutable source snapshots for three specific candidates:
- `prometheus/prometheus-mcp` (v0.18.0)
- `snyk/studio-mcp` (v1.14.0)
- `microsoft/playwright-mcp` (v0.0.78)

## Snapshot method
The source code was retrieved via direct archive download of the release tags to a temporary isolated location. The zip archives were hashed (SHA-256), extracted, and static codebase inventories were conducted. Temporary files were cleaned up after review.

## Prometheus MCP
Medium risk. The codebase reveals direct API client functionality to query Prometheus endpoints, raising the need for strict network boundary definitions and read-only backend user accounts.

## Snyk Studio MCP
High risk. Code analysis confirms the execution of `snyk` CLI tools and potential subprocess executions for ecosystem build tools (like Gradle, Maven). This demands execution in ephemeral sandboxed containers only.

## Microsoft Playwright MCP
High risk. Exposes deep browser automation capabilities including navigation, DOM manipulation, JS evaluation, and persistent storage state. Strict isolation is required to prevent indirect prompt injection or unintended internet navigation.

## Hash coverage
Archive SHA-256 hashes were captured for all three retrieved candidates. Content hashing at the individual file level (e.g. for `go.mod`, `package.json`, `LICENSE`) was also executed on key files.

## License conclusions
All three candidates have standalone `LICENSE` files asserting the Apache-2.0 license. The conclusion is `verified_with_conditions` as they carry required attribution and notice conditions.

## Security findings
- **Prometheus MCP**: External network API queries and potential metrics exposure.
- **Snyk Studio MCP**: Local subprocess execution and potential arbitrary code execution via ecosystem build tools.
- **Playwright MCP**: Complete browser access, file interactions, arbitrary JS evaluation, and potential credential extraction.

## Prompt-injection findings
- **Prometheus MCP**: Output manipulation could occur if external metric names or labels are injected.
- **Snyk Studio MCP**: Malicious package definitions or manifests in scanned folders could trigger RCE via build tools before the scan even completes.
- **Playwright MCP**: Web page content ingestion is highly susceptible to indirect prompt injection or XSS-like attacks.

## Candidate decision changes
There were no changes to the overarching decision states. All three candidates remain at `needs_security_review` due to the critical nature of their execution boundaries and risks.

## Snapshot limitations
The analysis was performed entirely statically on the downloaded source archive. Dynamic execution, dependency resolution, and runtime behaviors were not verified.

## Temporary-file cleanup
All extracted source directories and downloaded `.zip` files were permanently deleted from the temporary workspace directory.

## Recommended next step
Plan the adaptation and strict execution boundaries for the candidates, outlining how to safely launch Snyk Studio or Playwright in isolated network-restricted environments before formal import.

Automated YAML validation: NOT RUN.
Reason: Python executable and PyYAML were unavailable in the existing environment.
Manual structural validation was completed.
No parser was installed.
