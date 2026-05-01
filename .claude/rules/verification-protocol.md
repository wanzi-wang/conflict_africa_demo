# Verification Protocol

After editing any R script, always tell the user how to verify.

## By script type

### Data-construction pipeline (clean / aggregate / check)
- Run: `Rscript code/d_03_acled_check.R` (or the matching verifier for the pipeline)
- Pass criteria: exit code 0, all checks PASS

### Analysis or figure scripts
- Tell user to `Rscript` the script
- State expected output: number of observations, key statistics, figure path
- If the script writes `.rds` or figures, state the output path

### New scripts
- Include a self-check section at the bottom (row counts, column types, NA summaries)
- Print a summary the user can visually verify

## What to check
- Row count consistency (no unexpected drops between stages)
- Column names and types match downstream expectations
- No all-NA columns introduced
- Key statistics are in plausible ranges
- Arithmetic identities between stages (e.g., `sum(n_events_panel) == nrow(events_clean)`) — these catch silent NA drops, key duplications, and filter-order mistakes at once
