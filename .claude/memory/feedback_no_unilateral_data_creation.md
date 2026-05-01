---
name: No unilateral data creation
description: Never create CSV/RDS/derived data files without permission; write the code first, run only with approval
type: feedback
---

Do not create or overwrite data files (CSV, RDS, XLSX, derived tables) without explicit permission. Always write the code first, show it for review, and run it only after the user approves.

**Why:** Silently overwriting a data file destroys the previous version, which may have been the result of hours of upstream work. The cost of pausing for confirmation is zero; the cost of an unintended overwrite can be a full re-run of the pipeline.

**How to apply:** When a script writes to disk (e.g., `saveRDS`, `writeData` + `saveWorkbook`, `write_csv`), do not invoke it from the assistant. Instead, show the code, point out what will be written and where, and wait for the user to run it.
