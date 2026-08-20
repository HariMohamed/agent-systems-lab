# V3 Resource Budget Report

## Status
**PASS WITH CONDITIONS** (Logical verification passed; physical resource limits remain blocked on environment).

## Implemented
- `BudgetRegistry` and `BudgetEngine` added to `scripts/evaluate.py`.
- Enforces per-actor limits (`max_tool_calls`, `max_total_tokens`, `max_subagents`).
- Global limits (`max_agents`, `max_active_executions`).
- Strict Reservation Lifecycle (`RESERVED`, `CONSUMED`, `RELEASED`, `UNKNOWN`).
- `ProviderUsage` data structure separating token logic from monetary exactness.
- Integration into the `evaluate_scenario` core execution loop immediately prior to Sandbox and Delegation.

## Verified
- Unauthorized actions cannot reserve budget.
- Child agents cannot escalate budgets.
- Sibling isolation is enforced.
- Concurrency limits are deterministic.
- Unknown outcomes do not cause unsafe refunds.
- Prompt injection cannot modify budget authority.

## Designed But Not Verified
- Time budgets (implemented monotonic limits in spec, but deterministic harness skips real time delays).
- Cost constraints dependent on real API calls (provider pricing dynamically fetched).

## Blocked
- Physical Sandbox resource exhaustion (CPU limit, Memory exhaustion) remains blocked on Docker daemon availability.

## Security Findings
- The original design incorrectly refunded budgets if execution timed out (`timeout`). This was fixed in `BudgetEngine` by introducing the `UNKNOWN` reservation status. This ensures that an operation that potentially consumed external resources (like an API call) isn't refunded locally, preventing double-spending.
- Orchestration bounds now fail closed before allocating budget if global thresholds are met, optimizing resource exhaustion defensively.
