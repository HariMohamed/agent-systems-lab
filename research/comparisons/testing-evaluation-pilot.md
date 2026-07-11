# Candidate Comparison

## Capability
Testing strategy and evaluation

## Candidates
* playwright-mcp v0.0.78 (Microsoft Playwright MCP)
* mcp-playwright (Community Playwright MCP)
* mcp-server-tester (Evaluation tool)
* evals (Non-MCP evaluation framework)

## Comparison scope
Browser automation capabilities and agent evaluation harnesses.

## Authoritative sources
* microsoft/playwright-mcp
* executeautomation/mcp-playwright
* steviec/mcp-server-tester
* openai/evals

## License comparison
All generally declare MIT, pending full review.

## Security comparison
Both Playwright implementations pose high risk due to arbitrary HTTP and DOM capabilities. MCP-Server-Tester also runs arbitrary scripts/npm dependencies. Evals carries prompt injection and sandbox risks.

## Responsibility and activation
Browser automation, test harness execution.

## Inputs and outputs
DOM structures, HTTP requests, test scenarios.

## Side effects
Navigating to arbitrary URLs, downloading files, executing third-party javascript.

## Platform compatibility
Browsers (Chromium, Firefox, WebKit), Python/Node execution environments.

## Maintenance
Microsoft and OpenAI are official tier 1 maintainers. 

## Local overlap
mcp-server-tester and evals are complementary to internal skill evaluation checklists.

## Evaluation evidence
Not deeply evaluated.

## Adaptation burden
High adaptation burden to sandbox browser capabilities efficiently without ballooning context window usage.

## Decision
* Outcome: prefer_candidate_a
* Preferred: CAND-0011 — playwright-mcp
* Compared against: CAND-0005 — mcp-playwright
* Scope: future source-snapshot priority only

* Outcome: defer
* Deferred: CAND-0012 — evals
* Scope: future evaluation consideration

## Unknowns
Exact executable boundaries, content hashes.

## Reviewer
Agent

| Feature | playwright-mcp | mcp-playwright | mcp-server-tester | evals |
| ------- | -------------- | -------------- | ----------------- | ----- |
| License | MIT | MIT | MIT | MIT |
| Security Risk | High | High | High | Medium |
| Overlap | Unique | Unique | Complementary | Complementary |
| Decision | needs_security_review | needs_security_review | needs_security_review | future |
