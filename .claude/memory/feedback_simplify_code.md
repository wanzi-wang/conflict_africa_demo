---
name: Simplify code; no premature abstractions
description: Workflow-specific R; no helpers or abstractions unless the same logic repeats at least three times
type: feedback
---

Write code for the specific task at hand. Don't introduce helper functions, abstractions, or no-op layers unless the same logic appears at least three times in the codebase. Verify package APIs before using them — never recall function signatures from training data.

**Why:** Premature abstractions are harder to read, harder to debug, and almost always solve hypothetical future problems instead of real current ones. A two-line block repeated twice is fine; the third repetition is when refactoring earns its keep.

**How to apply:** When tempted to extract a function or write a wrapper, count uses. If under three, inline the logic. When using an unfamiliar package or function, check its docs (or run a small test) rather than guessing the signature.
