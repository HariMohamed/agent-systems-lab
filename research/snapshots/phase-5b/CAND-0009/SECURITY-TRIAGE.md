# Security Triage: CAND-0009

### Snyk CLI Invocation

Status: verified
Risk: High
Behavior: Wraps the Snyk CLI and accepts configurations for automatic setup.
Default or optional: default
Execution boundary: local-state-change + external-service
Evidence:
- `pkg/mcp/main.go:L55-L55`
- Symbol: `configureFlags.StringP`
Impact: Triggers Snyk analysis which may execute ecosystem-specific logic on the local system.
Required mitigation: Execution inside ephemeral containers only.
Remaining unknowns: None

### Arbitrary Subprocess Execution (Gradle/Maven/npm)

Status: inference
Risk: High
Behavior: Malicious package definitions or manifests in scanned folders could trigger RCE via build tools before the scan even completes.
Default or optional: default (based on Snyk SCA mechanics)
Execution boundary: local-state-change
Evidence:
- Implicitly required by the Snyk engine for deep resolution.
- Official documentation.
Impact: RCE via build tools.
Required mitigation: Strict sandboxing.
Remaining unknowns: Whether the wrapper specifically overrides Snyk defaults to prevent this.

### Telemetry

Status: inference
Risk: Low
Behavior: Standard Snyk analytics collection during scans.
Default or optional: default
Execution boundary: external-service
Evidence:
- Snyk CLI behavior documentation.
Impact: Potential metadata leakage.
Required mitigation: Network controls.
Remaining unknowns: Telemetry opt-out within the MCP wrapper.
