# Architecture

- Prefer simple maintainable designs: Avoid overly complex or "clever" solutions. Code should be easy to read and understand.
- Avoid premature abstraction: Do not introduce interfaces, base classes, or generic types until there is a concrete need for them.
- Preserve API contracts: Do not break existing public interfaces, function signatures, or expected behavior without a coordinated transition plan.
- Consider backwards compatibility: Ensure changes do not break existing consumers of the code.
- Document meaningful architectural decisions: When making a significant design choice, capture the context, alternatives considered, and rationale in the appropriate documentation (e.g., ADRs or comments).
