# Phase 5D — Prometheus Methodology Adaptation Plan

## Executive verdict
The official Prometheus MCP (CAND-0007) successfully provided the required methodology for building a native observability-investigation workflow. The adaptation plan strictly bounds agent operations to read-only queries and safely isolates state-change, remediation, and destructive commands. The proposed workflow focuses purely on translating raw signals into correlated, confident reports without requiring upstream MCP dependencies.

No workflow was implemented, imported, installed, configured, executed, approved, published, or deployed during Phase 5D.

## Scope
This adaptation phase targeted the observability methodology demonstrated by `CAND-0007` to design a native `observability-investigation` workflow artifact, focusing explicitly on safe production telemetry triage.

## Source constraints
The upstream candidate logic for direct TSDB mutation, automated service reloading, and unstructured network access was discarded. Only the general methodology regarding query structuring and metadata inspection was retained for adaptation.

## Proposed repository artifact
A native workflow named `observability-investigation`, intended for the `workflows/observability-investigation/` directory as a single consolidated `WORKFLOW.md` artifact incorporating safety boundaries directly to conserve prompt-size.

## Responsibility boundary
The workflow bridges the gap between basic health checks and detailed code analysis. It explicitly handles signal correlation (logs, metrics, traces, alerts), while leaving formal implementation or code modifications to separate workflows like `systematic-debugging`. Remediation is strictly prohibited.

## Safety boundaries
The workflow mandates strict read-only execution, enforcing human approval for any infrastructure deployment or configuration change. Prompt-injection risks originating from untrusted logs or trace attributes are managed by treating telemetry strictly as data strings and separating them from executable instructions.

## Platform neutrality
The workflow defines generalized phases applicable across any standard backend (Prometheus, OpenTelemetry, Datadog) rather than locking the agent into PromQL specifics. Optional platform adapters may be documented later if necessary.

## Local overlap
Overlaps slightly with `systematic-debugging` and `verification-before-completion`, but clarifies its distinct role: gathering distributed operational evidence rather than parsing application source code or verifying final task completion.

## Evaluation coverage
A full static behavioral evaluation plan has been defined across activation, non-activation, safety, and evidence scenarios to ensure agents correctly identify scope boundaries and reject unauthorized actions like TSDB mutations or payload deletions.

## Prompt-size considerations
The target artifact will be condensed into a single file of under 200 lines to preserve sufficient context window for consuming large arrays of JSON logs or metric values during active triage.

## Licensing approach
Minor structural overlaps with original Prometheus methodologies will be properly attributed, preserving Apache-2.0 `LICENSE` and `NOTICE` references if documentation patterns are mirrored in the final markdown workflow.

## Implementation readiness
The conceptual boundaries, evidence hierarchy, and output contracts are fully formulated. The workflow is ready for controlled drafting.

## Remaining blockers
Determining the exact maximum line count of logs an agent should pull into context without experiencing degraded instruction following.

## Recommended next gate
`ready_for_controlled_implementation`
