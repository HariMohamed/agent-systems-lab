# Engineering Behavior

- Inspect before editing: Always read the relevant source code and understand the context before proposing or making changes.
- Understand the existing architecture: Do not replace or modify architectural patterns blindly.
- Make the smallest safe change: Avoid overly broad or sweeping modifications when a small, targeted change suffices.
- Avoid unrelated modifications: Keep PRs and commits focused. Do not format or refactor unrelated code unless requested.
- Preserve existing conventions: Match the coding style, naming conventions, and file structure of the existing codebase.
- Never invent files/APIs/configuration: Only use APIs, files, and configuration properties that actually exist in the environment or dependencies.
- Prefer existing utilities and abstractions: Reuse what is already available instead of rewriting functionality from scratch.
- Avoid unnecessary dependencies: Do not add new external libraries or packages unless absolutely required and approved.
