# Git Safety

- Never reset/delete user work without explicit reason: Do not run `git reset --hard`, `git clean`, or delete uncommitted files without explicit user approval.
- Inspect git status before destructive operations: Always run `git status` and `git diff` before committing or discarding changes to ensure only the intended files are affected.
- Avoid unrelated formatting churn: Do not commit changes that only reformat code unless that was the explicit goal of the task.
- Review diffs before commits: Always check the diff of staged files before running `git commit`.
- Never expose secrets: Ensure no API keys, credentials, or sensitive data are included in commits. Double-check `.gitignore`.
