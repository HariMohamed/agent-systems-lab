# Security Triage: CAND-0011

### Browser Capability Wrapper

Status: verified
Risk: High
Behavior: Exposes the full playwright-core toolset via module exports.
Default or optional: default
Execution boundary: browser_automation
Evidence:
- `index.js:L18-L19`
- Symbol: `tools.createConnection`
Impact: Grants broad browser automation capabilities indirectly.
Required mitigation: Network controls and sandboxing.
Remaining unknowns: None

### Arbitrary Page Script Evaluation

Status: verified
Risk: High
Behavior: Configuration supports adding arbitrary initialization scripts evaluated in every page.
Default or optional: optional
Execution boundary: browser_automation
Evidence:
- `config.d.ts:L94-L100`
- Symbol: `launchOptions`
Impact: arbitrary browser-action risk and untrusted webpage-content risk.
Required mitigation: Restrict allowed scripts and pages.
Remaining unknowns: None

### Persistent Browser Storage and Network Routing

Status: inference
Risk: High
Behavior: Full Playwright capabilities inherently imply storage state modification, cookie management, and arbitrary web navigation.
Default or optional: default
Execution boundary: browser_automation
Evidence:
- Implicitly required by the Playwright API provided by the `playwright-core` delegate.
Impact: indirect prompt-injection risk, credential/session exposure risk, filesystem-output risk.
Required mitigation: Ephemeral browser profiles, restricted network routing, input sanitization.
Remaining unknowns: The exact exposure limits imposed by the core MCP implementation.
