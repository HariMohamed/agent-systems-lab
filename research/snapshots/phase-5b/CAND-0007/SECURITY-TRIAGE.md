# Security Triage: CAND-0007

### TSDB Admin Tools

Status: verified
Risk: High
Behavior: Exposes dangerous TSDB Admin APIs including snapshot, delete_series, and clean_tombstones.
Default or optional: optional
Execution boundary: api_client
Evidence:
- `cmd/prometheus-mcp-server/main.go:L111-L115`
- Symbol: `flagEnableTsdbAdminTools`
Impact: Could result in deletion of critical monitoring data.
Required mitigation: Ensure flag `dangerous.enable-tsdb-admin-tools` is disabled.
Remaining unknowns: None

### Metric Labels Injection

Status: inference
Risk: Medium
Behavior: MCP prompts and queries could be manipulated by external metric labels.
Default or optional: default
Execution boundary: api_client
Evidence:
- `pkg/prometheus/api.go`
- Prometheus TSDB label ingestion
Impact: Output manipulation could occur if external metric names or labels are injected into model-visible outputs.
Required mitigation: Network isolation and read-only Prometheus accounts.
Remaining unknowns: Exact query truncation limits.

### Authentication Configuration

Status: verified
Risk: Medium
Behavior: Handles HTTP authentication configuration (bearer token / basic).
Default or optional: optional
Execution boundary: api_client
Evidence:
- `pkg/prometheus/api.go`
Impact: Access to metrics is protected.
Required mitigation: Secure storage of backend credentials.
Remaining unknowns: None
