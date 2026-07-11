# Phase 3A - Provenance Clustering

## Executive verdict

There are 15 remaining incubating skills. The repository is not ready for broad new skill discovery yet.

Most remaining skills cluster into a probable Superpowers-derived workflow family. One large skill is a probable Vercel-derived React/Next.js bundle. `writing-skills` appears mixed-origin because it combines Superpowers-style process guidance with a large local copy of Anthropic skill-authoring documentation. `find-skills` is high-risk and should be adapted before any broad external discovery because it mixes discovery, quality screening, and installation, including a confirmation-skipping install command.

Recommended next phase: Phase 3B should batch-verify the probable Superpowers-derived family against `obra/superpowers`, but review `find-skills` first or in parallel as a safety gate for future discovery.

## Remaining incubating inventory

| Skill | Path | Files | Approx size | Embedded repository URLs | Named authors | Declared license | Declared version | Model/tool assumptions | Suspected upstream family | Confidence |
| ----- | ---- | ----: | ----------: | ------------------------ | ------------- | ---------------- | ---------------- | ---------------------- | ------------------------- | ---------- |
| `brainstorming` | `skills/incubating/brainstorming/` | 8 | 52.5 KB | `https://github.com/obra/superpowers` in `scripts/frame-template.html:199` | none in skill metadata | none | none | Browser/local server, shell scripts, Codex/Gemini/Claude notes, `.superpowers/` paths | probable Superpowers-derived | HIGH |
| `dispatching-parallel-agents` | `skills/incubating/dispatching-parallel-agents/` | 1 | 6.4 KB | none found | none | none | none | Claude Code-style `Task` tool, parallel subagents | probable Superpowers-derived | MEDIUM |
| `executing-plans` | `skills/incubating/executing-plans/` | 1 | 2.5 KB | none found | none | none | none | Superpowers sub-skills, Claude Code/Codex subagent assumptions | probable Superpowers-derived | HIGH |
| `find-skills` | `skills/incubating/find-skills/` | 1 | 5.4 KB | `https://skills.sh/`, skills.sh package URLs | names `vercel-labs`, `anthropics`, `microsoft`, `ComposioHQ` as sources | none | none | `npx skills`, web leaderboard, GitHub reputation checks | unknown or marketplace-discovery custom | LOW |
| `finishing-a-development-branch` | `skills/incubating/finishing-a-development-branch/` | 1 | 7.1 KB | none found | none | none | none | shell, git, GitHub CLI, merge/push/PR/worktree cleanup | probable Superpowers-derived | HIGH |
| `receiving-code-review` | `skills/incubating/receiving-code-review/` | 1 | 6.3 KB | none found | none | none | none | Claude-style behavioral rules, GitHub thread replies | probable Superpowers-derived or local custom | MEDIUM |
| `requesting-code-review` | `skills/incubating/requesting-code-review/` | 2 | 7.6 KB | none found | none | none | none | `Task` subagent, git SHAs, code-review prompt template | probable Superpowers-derived | MEDIUM |
| `subagent-driven-development` | `skills/incubating/subagent-driven-development/` | 4 | 19.9 KB | none found | none | none | none | Superpowers sub-skills, fresh subagents, commits, model selection | probable Superpowers-derived | HIGH |
| `systematic-debugging` | `skills/incubating/systematic-debugging/` | 11 | 40.7 KB | none found | creation log cites `~/.claude/CLAUDE.md` | none | created date in `CREATION-LOG.md:118` | shell, tests, diagnostic instrumentation, `.claude`, keychain examples | probable Superpowers-derived with possible personal-Claude source material | MEDIUM |
| `test-driven-development` | `skills/incubating/test-driven-development/` | 2 | 18.1 KB | none found | none | none | none | test runner shell commands, strong deletion/rewrite rules | probable Superpowers-derived | MEDIUM |
| `using-git-worktrees` | `skills/incubating/using-git-worktrees/` | 1 | 8.0 KB | none found | none | none | none | git worktrees, package installs, baseline tests, `.config/superpowers` | probable Superpowers-derived | HIGH |
| `using-superpowers` | `skills/incubating/using-superpowers/` | 4 | 12.7 KB | none found | none | none | none | Claude Code, Copilot CLI, Gemini CLI, Codex mappings | probable Superpowers-derived | HIGH |
| `vercel-react-best-practices` | `skills/incubating/vercel-react-best-practices/` | 76 | 230.4 KB | React, Next.js, SWR, Vercel blog, GitHub dependency links | `author: vercel`; README credits `@shuding` at Vercel | MIT in `SKILL.md:4` | `1.0.0` in `SKILL.md:7`, `metadata.json:1` | React/Next.js, Vercel, generated `AGENTS.md`, pnpm build workflow | probable Vercel-derived | HIGH |
| `writing-plans` | `skills/incubating/writing-plans/` | 2 | 7.8 KB | none found | none | none | none | Superpowers planning docs, commits, subagent handoff | probable Superpowers-derived | HIGH |
| `writing-skills` | `skills/incubating/writing-skills/` | 7 | 103.3 KB | `agentskills.io`, Anthropic docs/images, Claude docs links | Anthropic docs as copied reference; persuasion references cite Cialdini/Meincke | none local | none | Claude/Anthropic skill architecture, subagent tests, render script | mixed Superpowers plus Anthropic docs | MEDIUM |

Local Git history: all remaining incubating skills were added in baseline commit `90938e7 chore: establish initial agent skills repository baseline`. Later commits in local history only reviewed/adapted/promoted `verification-before-completion`.

## Source-family clusters

### Probable Superpowers-derived

Skills:

- `brainstorming`
- `dispatching-parallel-agents`
- `executing-plans`
- `finishing-a-development-branch`
- `receiving-code-review`
- `requesting-code-review`
- `subagent-driven-development`
- `systematic-debugging`
- `test-driven-development`
- `using-git-worktrees`
- `using-superpowers`
- `writing-plans`

Common evidence:

- Many local files reference `superpowers:*` sub-skills, `docs/superpowers/...`, `.superpowers/...`, or `~/.config/superpowers/...`.
- `brainstorming/scripts/frame-template.html:199` links to `https://github.com/obra/superpowers`.
- The official `obra/superpowers` repository lists matching skill directories for the core family.
- The official `obra/superpowers` package identifies version `6.1.1`.
- The official `obra/superpowers` license is MIT and names Jesse Vincent as copyright holder.

Shared verification:

- One repository-level MIT license verification likely covers the family if exact upstream files are confirmed under the same repository and version.
- Each skill still requires individual exact-content comparison, because local files may have been adapted, line endings may differ, and supporting files/scripts have separate safety implications.

Redistribution risks:

- No local license notice is present for these skills yet.
- Some skills instruct commits, pushes, merges, installs, worktree cleanup, local server startup, or file deletion. Those conflict with repository safety policy unless adapted.
- Some content is platform-specific to Claude Code or Superpowers and must be made portable or explicitly scoped.

Likely adaptation burden: medium to high. The conceptual value is strong, but safety boundaries and tone need repeated fixes across the family.

### Probable Vercel-derived

Skill:

- `vercel-react-best-practices`

Common evidence:

- Local `SKILL.md:4` declares MIT.
- Local `SKILL.md:6-7` declares `author: vercel` and `version: "1.0.0"`.
- Local `metadata.json:1` names `Vercel Engineering`, date `January 2026`, and official React/Next/Vercel references.
- Local `README.md:123` says it was originally created by `@shuding` at Vercel.
- Official `vercel-labs/agent-skills` repository lists `react-best-practices` as an available skill and describes it as React/Next.js performance guidance from Vercel Engineering.
- Official raw upstream `skills/react-best-practices/SKILL.md` and `metadata.json` match the local frontmatter and metadata structure at a high level; exact-content comparison remains undone.

Shared verification:

- Verify `vercel-labs/agent-skills` repository license once.
- Compare every local file to the upstream `skills/react-best-practices/` tree, including generated `AGENTS.md` and each rule file.

Redistribution risks:

- Local package is large and includes generated maintainer files plus rule sources.
- README includes `pnpm install` and build workflow commands. These are project-maintainer instructions, not runtime skill instructions, and should be separated or removed before approval.
- Some references include third-party projects and docs; they are citations but should not be treated as licensed source material without review.

Likely adaptation burden: medium. Provenance evidence is strong, but size and generated content raise packaging and prompt-bloat questions.

### Mixed Superpowers plus Anthropic docs

Skill:

- `writing-skills`

Common evidence:

- Local `SKILL.md` uses Superpowers-style requirements, references `superpowers:test-driven-development`, and includes a render script plus pressure-test methodology.
- Local `anthropic-best-practices.md:1-5` is an apparent copy of Anthropic skill authoring documentation.
- Local `anthropic-best-practices.md:13`, `249`, `253`, and `919` contain Anthropic docs and `mintcdn.com/anthropic-claude-docs` assets.
- Anthropic official docs contain the same best-practices topic and guidance, including concise skill design, degrees of freedom, frontmatter requirements, and testing across models.
- Official `anthropics/skills` repository states many skills are Apache-2.0 but some document skills are source-available, so license status must be verified per copied source, not inferred.

Shared verification:

- Superpowers portions may share the Superpowers MIT license if exact upstream provenance is confirmed.
- Anthropic documentation copy requires separate licensing/permission verification from official Anthropic docs or repository notices.

Redistribution risks:

- Mixed origin means a single MIT notice may be insufficient.
- Large copied documentation and images/URLs may carry different terms.
- The local skill includes deployment language, commit/push language, persuasion/rationalization material, and executable rendering script references.

Likely adaptation burden: high.

### Unknown or custom discovery skill

Skill:

- `find-skills`

Common evidence:

- No local upstream source, author, license, or version declaration.
- It references `skills.sh`, `npx skills`, and marketplace sources, but not a specific source repository for itself.

Shared verification:

- None. This requires individual provenance and safety review.

Redistribution risks:

- It recommends installing skills globally with `-y`, which skips confirmation.
- It relies on popularity, install counts, and GitHub stars as quality proxies without requiring license, version, hash, or exact-source capture.
- It treats third-party discovery surfaces as useful but does not clearly classify retrieved instructions as untrusted.

Likely adaptation burden: high.

## Embedded provenance evidence

Local evidence with line references:

- `skills/incubating/brainstorming/scripts/frame-template.html:199` links to `https://github.com/obra/superpowers`.
- `skills/incubating/brainstorming/SKILL.md:29` and `:111` write specs under `docs/superpowers/specs/...`.
- `skills/incubating/brainstorming/spec-document-reviewer-prompt.md:7` references `docs/superpowers/specs/`.
- `skills/incubating/brainstorming/visual-companion.md:39-48` references `.superpowers/brainstorm/` session paths.
- `skills/incubating/executing-plans/SKILL.md:14` names Superpowers and Claude Code/Codex subagent support.
- `skills/incubating/executing-plans/SKILL.md:36` requires `superpowers:finishing-a-development-branch`.
- `skills/incubating/executing-plans/SKILL.md:68-70` references `superpowers:using-git-worktrees`, `superpowers:writing-plans`, and `superpowers:finishing-a-development-branch`.
- `skills/incubating/subagent-driven-development/SKILL.md:270-279` references multiple `superpowers:*` workflow skills.
- `skills/incubating/systematic-debugging/CREATION-LOG.md:7` says the debugging framework was extracted from `~/.claude/CLAUDE.md`.
- `skills/incubating/systematic-debugging/CREATION-LOG.md:118` records `Created: 2025-10-03`.
- `skills/incubating/systematic-debugging/SKILL.md:287-288` references `superpowers:test-driven-development` and `superpowers:verification-before-completion`.
- `skills/incubating/using-git-worktrees/SKILL.md:79`, `:97`, and `:106` reference `~/.config/superpowers/worktrees/`.
- `skills/incubating/using-superpowers/SKILL.md:2-3` identifies the skill as `using-superpowers`.
- `skills/incubating/using-superpowers/SKILL.md:22-26` defines a Superpowers instruction priority model.
- `skills/incubating/using-superpowers/SKILL.md:40` references Copilot, Codex, and Gemini mapping files.
- `skills/incubating/writing-plans/SKILL.md:18` saves plans under `docs/superpowers/plans/...`.
- `skills/incubating/writing-plans/SKILL.md:147-151` requires `superpowers:subagent-driven-development` or `superpowers:executing-plans`.
- `skills/incubating/vercel-react-best-practices/SKILL.md:4` declares `license: MIT`.
- `skills/incubating/vercel-react-best-practices/SKILL.md:6-7` declares `author: vercel` and `version: "1.0.0"`.
- `skills/incubating/vercel-react-best-practices/metadata.json:1` names `Vercel Engineering`, `January 2026`, and official references.
- `skills/incubating/vercel-react-best-practices/README.md:123` credits `@shuding` at Vercel.
- `skills/incubating/writing-skills/SKILL.md:96` links to `https://agentskills.io/specification`.
- `skills/incubating/writing-skills/SKILL.md:20` points to `anthropic-best-practices.md` as official guidance.
- `skills/incubating/writing-skills/anthropic-best-practices.md:1-5` identifies Anthropic skill authoring guidance.
- `skills/incubating/writing-skills/anthropic-best-practices.md:13` links to Claude context-window docs.
- `skills/incubating/writing-skills/anthropic-best-practices.md:249`, `:253`, and `:919` embed Anthropic docs image URLs.
- `skills/incubating/find-skills/SKILL.md:32` and `:46` reference `https://skills.sh/`.
- `skills/incubating/find-skills/SKILL.md:49-50` cites `vercel-labs/agent-skills` and `anthropics/skills` as popular sources.
- `skills/incubating/find-skills/SKILL.md:91-93` gives an install command and skills.sh link for `vercel-labs/agent-skills@react-best-practices`.

External authoritative evidence consulted:

- Official `obra/superpowers` GitHub repository lists matching skill directories under `skills/` and exposes a repository MIT license and package version `6.1.1`.
- Official `vercel-labs/agent-skills` GitHub repository lists `react-best-practices` and describes it as React/Next.js performance guidance from Vercel Engineering.
- Official `anthropics/skills` GitHub repository describes Anthropic skill examples and cautions that many are Apache-2.0 while some document skills are source-available, requiring per-source license care.
- Official Claude Platform skill authoring docs describe skill best practices, frontmatter requirements, and testing guidance.

## Family-level risks

| Family | Licensing clarity | Traceability | Prompt-injection exposure | State-changing risk | Install risk | Commit/push/deploy risk | Secret risk | Shell risk | Model assumptions | Prompt bloat | Duplication |
| ------ | ----------------- | ------------ | ------------------------- | ------------------- | ------------ | ----------------------- | ----------- | ---------- | ----------------- | ------------ | ----------- |
| probable Superpowers-derived | likely MIT if exact upstream confirmed, but local notices missing | medium; local baseline import only, upstream exact hashes pending | medium; skills redefine process and priority in places | high for brainstorming/worktrees/finishing/TDD | high in `using-git-worktrees` setup | high in brainstorming, writing-plans, subagent workflow, finishing | medium; debugging examples mention secrets/keychains | high; shell/git/scripts | high; Claude Code, Codex, Gemini, Superpowers | medium to high | high workflow overlap |
| probable Vercel-derived | local MIT declared; upstream license still must be verified | high for repository family, exact tree pending | low to medium; mostly reference guidance | low in runtime, medium in maintainer README | medium due `pnpm install` in README | low runtime, medium maintainer workflow | low; includes token-minimization advice | medium because README/build files exist | React/Next/Vercel-specific | high due 230 KB and generated `AGENTS.md` | high inside generated/source rule duplication |
| mixed Superpowers plus Anthropic docs | unclear until both sources verified | medium; Superpowers likely, Anthropic copied docs need exact source | medium; copied docs include tool assumptions | medium | medium; docs mention package installs | medium; skill deployment checklist mentions commit/push | medium; docs mention tokens and executable scripts | medium; render script and examples | high; Claude/Anthropic-specific | very high | high with TDD/testing skills |
| unknown `find-skills` | unknown | low | high; external marketplace/search outputs are not framed as untrusted | medium | high; global install and `-y` | low direct, but imports can enable later actions | medium; external packages unknown | high via `npx skills` | ecosystem-specific | low | overlaps future discovery process |

## Duplication observations

- `executing-plans`, `subagent-driven-development`, `writing-plans`, `requesting-code-review`, and `finishing-a-development-branch` form a tightly coupled implementation lifecycle.
- `test-driven-development`, `systematic-debugging`, and `writing-skills` repeat strong anti-rationalization language and deletion/start-over enforcement.
- `requesting-code-review` and `subagent-driven-development` both embed code-reviewer flows.
- `vercel-react-best-practices` includes both source rule files and generated `AGENTS.md`; this is useful for upstream maintainers but duplicative for a runtime skill.
- `writing-skills` includes a full Anthropic best-practices document plus local Superpowers-style guidance; the local skill should probably reference official docs rather than vendoring them, unless license and preservation requirements are clear.

## Batch-verification opportunities

- Verify `obra/superpowers` repository license, package version, author, release tags, and `skills/` tree once.
- Hash-compare all probable Superpowers skill files against one pinned upstream commit or release in one batch.
- Produce one shared MIT attribution template for exact Superpowers-derived skills, then add per-skill file manifests and adaptation notes individually.
- Search all probable Superpowers skills once for repeated unsafe patterns: commits, pushes, installs, destructive cleanup, secret/keychain examples, priority redefinition, and platform-specific tool names.
- Verify `vercel-labs/agent-skills` repository license and `skills/react-best-practices/` tree once, then compare all 76 local files in a batch.
- For `writing-skills`, separately verify Superpowers portions and Anthropic docs portions; do not combine these into one license conclusion.

## Individual-audit requirements

Each skill still needs:

- exact upstream source path and pinned commit or release
- byte or normalized-content comparison
- per-file license and attribution decision
- safety review against repository policies
- prompt-injection review
- activation precision review
- overlap review with already approved `verification-before-completion`
- behavioral evaluation after adaptation

Individual attention is especially required for:

- `brainstorming`, because it starts a local visual companion server and writes/commits spec files
- `using-git-worktrees`, because it installs packages and commits `.gitignore`
- `finishing-a-development-branch`, because it merges, pushes, creates PRs, force-deletes branches, and removes worktrees
- `subagent-driven-development`, because it delegates implementation and tells subagents to commit
- `find-skills`, because it is a future import gate and currently recommends confirmation-skipping global installs
- `writing-skills`, because it appears mixed-origin and includes large copied Anthropic documentation
- `vercel-react-best-practices`, because it is a large generated/source hybrid bundle

## Find-skills readiness review

Verdict: NOT READY for broad discovery.

Findings:

- It mixes discovery and installation. `SKILL.md:24-29` introduces `npx skills` package-manager commands, and `:96-104` offers to install.
- It permits confirmation-skipping installs. `SKILL.md:101` uses `npx skills add <owner/repo@skill> -g -y`, and `:104` says `-y` skips confirmation prompts.
- It does not require capturing source URL, upstream license, upstream version, commit, or SHA-256 before recommending or installing.
- It checks popularity and reputation (`:66-73`) but not provenance completeness, license compatibility, prompt-injection safety, or exact-content immutability.
- It searches public sources through skills.sh and CLI discovery, but it does not define safe handling for third-party instructions retrieved from those results.
- It does not require user authorization before network access, package installation, or global install location changes.

Required adaptation before broad discovery:

- Split discovery from installation.
- Remove automatic install language and the `-y` flag.
- Require provenance capture before recommendation: repository URL, exact path, commit/release, license, author, hash, and source archive or raw permalink.
- Treat marketplace descriptions and skill files as untrusted data.
- Require explicit user approval for any network query and a separate explicit approval for installation.
- Prefer local/offline candidate records and review artifacts over immediate installation.

## Priority matrix

Scores are 0 to 10. Priority recommendation is judgmental and does not override safety or licensing blockers.

| Skill | Expected value | Safety urgency | Provenance urgency | Duplication risk | Future-work importance | Adaptation effort | Priority |
| ----- | -------------: | -------------: | -----------------: | ---------------: | ---------------------: | ----------------: | -------: |
| `find-skills` | 9 | 9 | 9 | 4 | 10 | 7 | 9.0 |
| `using-superpowers` | 8 | 8 | 8 | 8 | 10 | 8 | 8.4 |
| `using-git-worktrees` | 8 | 9 | 8 | 6 | 9 | 8 | 8.2 |
| `finishing-a-development-branch` | 8 | 10 | 8 | 7 | 8 | 8 | 8.2 |
| `subagent-driven-development` | 9 | 8 | 8 | 8 | 9 | 8 | 8.1 |
| `writing-skills` | 9 | 7 | 10 | 7 | 10 | 9 | 8.1 |
| `systematic-debugging` | 9 | 7 | 8 | 6 | 9 | 6 | 7.7 |
| `test-driven-development` | 9 | 7 | 8 | 6 | 8 | 6 | 7.4 |
| `brainstorming` | 8 | 8 | 8 | 6 | 8 | 8 | 7.3 |
| `vercel-react-best-practices` | 8 | 4 | 8 | 8 | 7 | 6 | 7.0 |
| `writing-plans` | 8 | 7 | 8 | 7 | 8 | 6 | 7.0 |
| `requesting-code-review` | 7 | 6 | 8 | 7 | 7 | 5 | 6.6 |
| `receiving-code-review` | 7 | 5 | 7 | 5 | 7 | 5 | 6.0 |
| `executing-plans` | 7 | 6 | 8 | 7 | 7 | 5 | 6.0 |
| `dispatching-parallel-agents` | 6 | 5 | 7 | 6 | 6 | 4 | 5.6 |

Highest-risk skills:

- `finishing-a-development-branch`
- `find-skills`
- `using-git-worktrees`
- `subagent-driven-development`
- `brainstorming`
- `writing-skills`

Highest-value skills:

- `find-skills`
- `writing-skills`
- `systematic-debugging`
- `test-driven-development`
- `subagent-driven-development`
- `using-superpowers`
- `vercel-react-best-practices`

## Recommended audit order

1. `find-skills` - safety gate for future discovery; adapt before importing anything else.
2. Superpowers family license/provenance batch - verify `obra/superpowers` once, pin commit/release, compare all probable family files.
3. `using-superpowers` - root dispatcher that affects all other Superpowers-derived behavior.
4. `using-git-worktrees` and `finishing-a-development-branch` - highest state-changing risk pair.
5. `subagent-driven-development`, `executing-plans`, `writing-plans`, `requesting-code-review`, `receiving-code-review` - implementation workflow cluster.
6. `systematic-debugging` and `test-driven-development` - high-value discipline cluster; tone and authorization adaptation needed.
7. `brainstorming` - valuable but includes local server/scripts and commit behavior.
8. `writing-skills` - mixed-origin provenance and licensing work after Superpowers and Anthropic source rules are clear.
9. `vercel-react-best-practices` - likely valuable and lower runtime safety risk, but large exact-tree comparison.
10. `dispatching-parallel-agents` - smaller and lower risk; can be reviewed after core workflow primitives.

Next detailed review candidate: `find-skills`, because it controls future discovery and currently permits unsafe installation behavior.

Next family batch candidate: probable Superpowers-derived skills, because one upstream license/version/source investigation can cover many skills before individual behavioral audits.

## Broad-discovery prerequisites

Before importing new candidates across software development, DevOps, monitoring, testing, cybersecurity, infrastructure, databases, architecture, UI/UX, crawling/scraping, orchestration, workflows, scripts, evaluations, and prompt/context engineering, complete these prerequisites:

- Adapt and approve a safe `find-skills` or discovery workflow that never installs by default.
- Define a candidate intake record with source URL, raw permalink, commit/release, license, author, hash, file list, and retrieval date.
- Define a no-execute import rule for candidate scripts and instructions.
- Require license/provenance screening before any content adaptation.
- Require prompt-injection screening before treating external skill text as instructions.
- Require safety classification for installs, shell commands, secrets, network, destructive operations, commits, pushes, deployments, and database writes.
- Define batch hash-comparison tooling or a documented manual equivalent.
- Define attribution templates for MIT, Apache-2.0, source-available, and unknown-license cases.
- Decide whether generated files, examples, and maintainer READMEs should be retained in runtime skill packages.
- Establish a quarantine location and naming convention for newly imported candidates.
- Require per-skill REVIEW, PROVENANCE, and behavioral evaluation before approval.
- Keep repository README and THIRD_PARTY status synchronized after each lifecycle move.

## Next recommended phase

Phase 3B should be either:

1. `find-skills` focused safety/provenance review and adaptation, because it is the gate for future broad discovery; or
2. Superpowers family provenance batch, because most remaining incubating skills appear to come from `obra/superpowers` and can share upstream license/version/source verification.

Recommendation: do `find-skills` first as Phase 3B, then run the Superpowers family batch as Phase 3C.
