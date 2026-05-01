---
name: docupdate
description: Update all project documentation to reflect current codebase state
---

# Documentation Update

Update all project documentation to reflect the current state of the codebase.

## Steps

1. **Inventory first.** Glob for all README and doc files before touching anything:
   - `README.md` — top-level project intro
   - `code/README.md` — script catalog, run order (if present)
   - `data/README.md` — data codebook, variable dictionary
   - `docs/*.md` — architecture / workflow / handoff notes
   - `CLAUDE.md` — session instructions for Claude Code
2. **Read each file fully** before editing. Never assume contents.
3. **Scan for changes.** Read the scripts in `code/` and compare against what the docs say. Look for:
   - New or renamed scripts missing from the catalog
   - Changed variable names or column schemas
   - New data files not yet documented
   - Outdated run-order or dependency info
4. **Edit only what's stale.** Don't rewrite docs that are already correct.
5. **Show a summary table** of what was updated and why:
   | File | Change | Reason |
6. **Stage changes** with `git add` on the specific files. Do NOT commit.
