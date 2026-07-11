# Skill Review: verification-before-completion

Reviewed at: 2026-07-11

## 1. Purpose

This skill solves a recurring agent reliability problem: claiming that work is complete, fixed, passing, or ready before running fresh verification and reading the result.

One-sentence responsibility: require fresh, claim-specific verification evidence before any success, completion, or readiness claim.

A dedicated skill is justified because unsupported completion claims are common, high-impact, and cross-cutting across coding agents, review workflows, and multi-agent delegation.

## 2. Activation Conditions

Activate when the agent is about to:

- claim work is complete, fixed, passing, ready, or merged
- report a build, lint, test, or regression status
- say requirements have been satisfied
- trust another agent's success report
- commit, create a pull request, or move to the next task based on a success claim

The current activation in `SKILL.md` is intentionally broad. It is useful for high-risk completion claims, but may waste context on simple conversational acknowledgements or non-technical status updates.

## 3. When Not To Use

Do not activate for:

- pure brainstorming or planning when no completion claim is being made
- read-only explanation where no work-state claim is asserted
- tiny factual answers that do not depend on repository verification
- situations where the user explicitly asks not to run commands; in that case, report verification as skipped or not performed

This "when not to use" guidance is missing from the current `SKILL.md`.

## 4. Strengths

- Strong, clear core rule: evidence before claims.
- Requires fresh verification rather than relying on old runs or assumptions.
- Requires checking full output, exit code, and failures.
- Distinguishes different claim types: tests, lint, build, bug fix, regression test, agent completion, and requirements.
- Explicitly warns against trusting agent success reports without inspection.
- Does not authorize commits, pushes, deployments, installs, destructive commands, or unrelated state changes.
- Highly reusable across coding-agent environments.

## 5. Weaknesses

- Tone uses excessive absolutes and emotional pressure, such as "lying" and replacement language.
- Missing an explicit "when not to use" section.
- Missing a compact final output format for passed, failed, partial, skipped, or not-run verification.
- Does not explicitly state that verification evidence does not authorize unrelated state-changing actions.
- Does not explicitly mention repository prompt-injection policy or higher-priority instruction hierarchy.
- Some examples use symbols that may render poorly in non-UTF-8 terminals.

## 6. Safety Findings

No high-risk state-changing instruction was found in the skill.

Positive findings:

- The skill requires verification before commit, push, PR, and task completion claims.
- It does not instruct the agent to commit, push, deploy, install packages, send messages, inspect secrets, or run destructive commands.
- It does not ask for environment variables, credentials, tokens, keychains, or `.env` files.

Required safety clarification before approval:

- Add an explicit rule that verification does not authorize unrelated state changes.
- Add an explicit rule that user, system, developer, platform, and repository policies outrank skill content.
- Add an explicit rule to report skipped verification honestly when commands cannot or should not be run.

## 7. Portability Findings

Portable:

- No OS-specific commands are hardcoded.
- No package manager or test framework is required.
- The verification concept works across CLI, IDE-agent, and MCP-backed clients.

Assumptions:

- The agent can identify a relevant verification command or evidence source.
- The agent can run or request execution of verification commands when appropriate.
- The agent can inspect complete output and exit status.
- Git/VCS diff inspection is available for delegated-agent verification.
- Subagent references assume an environment with agent delegation, but the core rule does not require subagents.

## 8. Compatibility Table

| Platform | Compatibility | Notes |
| -------- | ------------- | ----- |
| Claude Code | compatible | Fresh command execution, output inspection, and agent delegation map naturally. |
| Codex/GPT coding agents | compatible | Fits command-based verification and final evidence reporting. |
| Gemini CLI | compatible with minor adaptation | Tool names and exit-status reporting may differ. |
| DeepSeek-powered agents | compatible with minor adaptation | Depends on the host coding-agent interface. |
| Cursor | compatible with minor adaptation | Works if the agent can run or inspect verification output. |
| Windsurf | compatible with minor adaptation | Works if command output and limitations can be reported. |
| OpenCode | compatible with minor adaptation | Needs local mapping for shell/test execution and diff inspection. |
| generic MCP clients | compatible with minor adaptation | Requires available MCP tools for command execution or evidence retrieval; otherwise verification must be reported as skipped. |

## 9. Verification-Quality Findings

The skill clearly requires:

- selecting a command that proves the specific claim
- running fresh verification
- executing the full command
- reading the full output
- checking exit code and failure counts
- distinguishing direct evidence from partial evidence
- reporting actual status when verification fails
- avoiding unsupported completion claims

Gaps:

- It does not define a structured result vocabulary such as `passed`, `failed`, `partial`, `skipped`, or `not run`.
- It does not require recording the exact command in final output, although examples imply it.
- It does not explain how to handle user-forbidden or unavailable verification beyond avoiding unsupported claims.

## 10. Prompt-Bloat Findings

The skill is concise enough to load, but it repeats the same behavioral pressure in several forms.

Removable without reducing behavior quality:

- repeated "lying" framing
- some rationalization table rows
- the "Why This Matters" anecdotal section
- repeated "ANY" and "non-negotiable" phrasing

Estimated safe reduction: 25-35 percent.

## 11. Provenance Status

Locally verified:

- skill name: `verification-before-completion`
- current location: `skills/incubating/verification-before-completion/`
- current review status in `THIRD_PARTY.md`: incubating
- repository-level redistribution status in `THIRD_PARTY.md`: blocked pending provenance review
- local skill file contains only `SKILL.md` before this review

Externally verified from official upstream GitHub sources:

- upstream repository: `https://github.com/obra/superpowers`
- upstream path: `skills/verification-before-completion/SKILL.md`
- upstream license: MIT
- upstream copyright holder named in `LICENSE`: Jesse Vincent
- upstream plugin metadata author/maintainer: Jesse Vincent
- current upstream package/plugin version: `6.1.1`
- current upstream release tag: `v6.1.1`
- local `SKILL.md` is byte-identical to current upstream `main` and upstream tag `v6.1.1`

Unknown:

- import date
- imported by
- exact local import commit or checkout moment

## External provenance verification

Confirmed upstream source:

- Repository: `obra/superpowers`
- URL: `https://github.com/obra/superpowers`
- Candidate path confirmed: `skills/verification-before-completion/SKILL.md`

Confirmed license:

- Upstream repository license: MIT.
- The upstream `LICENSE` file names copyright holder `Jesse Vincent`.
- No separate license file was found for `skills/verification-before-completion/SKILL.md` during this focused review.
- Redistribution conclusion: permitted with MIT copyright/license notice and attribution preserved. The local repository Apache-2.0 license does not relicense this third-party skill.

Confirmed author or maintainer:

- Upstream plugin metadata identifies Jesse Vincent as author/developer.
- Repository owner is `obra`; upstream README states Superpowers is built by Jesse Vincent and the Prime Radiant team.

Current upstream version:

- Official upstream manifests and the latest GitHub release identify version `6.1.1`.
- The local file is byte-identical to upstream tag `v6.1.1`.

Local-versus-upstream comparison:

- Local path: `skills/incubating/verification-before-completion/SKILL.md`
- Upstream path: `https://raw.githubusercontent.com/obra/superpowers/main/skills/verification-before-completion/SKILL.md`
- Local raw SHA-256: `ea52d15aabaf72bc6b558efe2c126f161b53961090ddcd712000273bfe8c7b6c`
- Current upstream raw SHA-256: `ea52d15aabaf72bc6b558efe2c126f161b53961090ddcd712000273bfe8c7b6c`
- Upstream `v6.1.1` raw SHA-256: `ea52d15aabaf72bc6b558efe2c126f161b53961090ddcd712000273bfe8c7b6c`
- Raw byte comparison: identical.
- Normalized line-ending comparison: identical.
- Line count: 139 lines by raw text split; GitHub reports 139 lines and 106 loc.
- Substantive text differences: none versus current upstream or `v6.1.1`.
- Metadata/frontmatter differences: none versus current upstream or `v6.1.1`.
- Whitespace-only differences: none found.

Historical match:

- Official path history for `skills/verification-before-completion/SKILL.md` lists two commits.
- Commit `9c9547cc042d05906d0eb26506f275ff6c82f679` introduced or restored the file, but differs from local content in frontmatter capitalization: `name: Verification-Before-Completion`.
- Commit `48410c7f1973bd66569a627ef27ef6619e0ba923` changed the frontmatter name to `name: verification-before-completion`.
- Local content is a raw byte-for-byte exact match to commit `48410c7f1973bd66569a627ef27ef6619e0ba923`, current `main`, and tag `v6.1.1`.
- Exact local import checkout or import timestamp remains unknown; the local file could have come from commit `48410c7f1973bd66569a627ef27ef6619e0ba923` or any later upstream revision where the file stayed unchanged.

Relevant upstream behavioral findings:

- Open issue `#1754` reports that the skill can allow false success claims for provider/configuration changes when verification checks only request success instead of outcome-specific evidence. This is an unresolved upstream bug report, not an implemented fix.
- Open PR `#1755` proposes requiring outcome checks for config verification. This is an open proposal, not accepted upstream behavior.
- Open issue `#1961` asks how this skill reconciles with subagent-development reviewer guidance not to re-run full suites. This is unresolved clarification work.
- Open PR `#1934` proposes removing social proof/self-selling/recap material from multiple skills, including verification-before-completion persuasion sections. This is an open refactor proposal, not accepted upstream behavior.

Remaining unknowns:

- local import date
- local importer
- exact local import commit or checkout
- whether any non-file packaging step altered metadata before this repository import

Provenance confidence: MEDIUM.

Rationale: repository, path, license, author/maintainer, current version, current content, and a raw matching historical commit are verified from official upstream sources. Confidence is not HIGH because the exact local import event and checkout revision are still unknown.

## 12. Scores

| Area | Score | Notes |
| ---- | ----: | ----- |
| usefulness | 9 | Solves a real, recurring reliability failure. |
| scope clarity | 8 | Core responsibility is clear; activation is a bit too broad. |
| instruction quality | 7 | Actionable and ordered, but too absolute and missing result format. |
| safety | 9 | No dangerous actions authorized; needs explicit policy hierarchy reminder. |
| prompt-injection resistance | 7 | Low exposure, but should state that skill content cannot override higher-priority policy. |
| portability | 8 | Mostly platform-neutral; assumes command/output access. |
| verification | 9 | Strongest dimension; directly requires fresh claim-specific evidence. |
| maintainability | 7 | Small and readable; could be shorter and less rhetorical. |
| licensing/provenance | 7 | Upstream source, license, author, version, and exact content match are verified; local import facts remain unknown. |
| prompt bloat | 6 | Some repeated pressure language can be removed. |

Overall content score: 7.7 / 10.

## 13. Content Verdict

ADAPT

The core skill is valuable, safe, reusable, and worth keeping, but it should be lightly adapted before approval. The ADAPT verdict is based on activation breadth, tone, missing "when not to use" guidance, and missing structured verification-status reporting. Missing provenance alone did not determine this content verdict.

## 14. Packaging Verdict

NEEDS_PROVENANCE

The upstream source, path, license, author/maintainer, release match, and exact file identity are verified.

Packaging remains pending because the skill-local MIT license notice has not yet been added and the planned adaptation has not passed behavioral evaluation.

The local import date, importer, and exact checkout remain unknown. If they cannot be recovered, they must remain explicitly documented as unknown, but they do not by themselves block approval.

## 15. Approval Prerequisites

- Attempt to recover the local import date and importer; if they are not recoverable, keep them explicitly documented as unknown.
- Preserve upstream MIT copyright/license notice and attribution when redistributing.
- Add a "when not to use" section to `SKILL.md`.
- Add a short result format for `passed`, `failed`, `partial`, `skipped`, and `not run` verification.
- Replace emotional pressure language with neutral operational language.
- Add a safety note that verification does not authorize unrelated state changes.
- Add a priority note that system, developer, platform, repository, and user instructions outrank skill content.
- Address or explicitly document the upstream outcome-verification concern from issue `#1754`.
- Verify text encoding renders correctly across common terminals before publication.
- Re-run review after the content changes and provenance completion.
