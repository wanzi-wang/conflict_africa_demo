---
name: Results format — CSV + PNG only
description: No .txt or .tex outputs from analysis scripts
type: feedback
---

Analysis scripts should write results as CSV (for tables) and PNG (for figures). Do not write .txt summaries or .tex tables.

**Why:** CSV is the universal interchange format and is easy to inspect, diff, and read into other tools. PNG is sufficient for review at any resolution. .txt and .tex outputs go stale, get regenerated inconsistently, and clutter the output directory.

**How to apply:** When writing a script that produces results, save tables as `.csv` via `write_csv()` and figures as `.png` via `ggsave()`. Skip any text-summary or LaTeX-table output unless explicitly requested.
