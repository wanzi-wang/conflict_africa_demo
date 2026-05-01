# CLAUDE.md — conflict_africa_demo

This file gives Claude Code persistent instructions for this repository.

## Project identity

This is a **standalone, self-contained** demonstration repository. It accompanies a pre-doctoral application and exists to showcase an AI-integrated empirical research workflow on public conflict-event data. It is **not** a working copy of any other research project; it is an independent codebase with its own data slice, paths, and lifecycle.

## CRITICAL: Isolation

This repository must operate **entirely within its own root directory**. Do not read from, write to, or otherwise touch paths under any unrelated personal research directory on this machine. Treat any other folder as if it does not exist.

Hard rules:
- **No absolute paths** outside this repo anywhere in code, scripts, configs, or docs.
- **No `setwd()`** to anything outside this repo.
- **No copying** files at runtime from outside locations. The data slice in `data/` is the only data this repo uses.
- **All paths must be relative** to the repo root, resolved via `here::here()`.
- If a script appears to reference an external project (stale comment, forgotten absolute path), **stop and flag it before running** — never silently "fix and run."

## Repository structure

```
.
├── code/                    R scripts (numbered pipeline)
├── data/Conflict/ACLED/     Public ACLED slice (Kenya, 2010-2020)
├── output/                  Figures and verification reports
├── docs/                    Workflow narrative and architecture notes
└── .claude/                 AI workflow artifacts
    ├── rules/               Behavioral rules for Claude Code
    ├── skills/              Custom slash commands
    └── memory/              Sample auto-memory entries
```

## Pipeline

The pipeline runs end-to-end on the committed Kenya slice:

| Script | Purpose | Verifier |
|---|---|---|
| `d_01_acled_clean.R` | Clean & deduplicate ACLED Kenya events | `d_03_acled_check.R` |
| `d_02_acled_aggregate.R` | Aggregate to year x admin1 x event_type panel | `d_03_acled_check.R` |
| `d_03_acled_check.R` | Verify panel integrity (11 named checks) | exit 0 = pass |
| `d_04_descriptive_figure.R` | Annual event counts figure | manual review |

> Note: scripts are prefixed `d_` to mark them as demo files. The numbering is sequential within this repo only.

Run from repo root: `Rscript code/<script>.R`.

## R conventions

- `snake_case` names, 100-char line width, `<-` for assignment, base pipe `|>` preferred
- `library()` calls at top of every script
- `set.seed(20260501)` before any random operation
- `na.rm = TRUE` explicit in summaries
- All paths via `here::here()`
- See `.claude/rules/r-code-conventions.md` for the full set

## Verification protocol

After editing any pipeline script:
- `d_01`/`d_02`/`d_03`: run `Rscript code/d_03_acled_check.R`, expect exit 0
- `d_04`: state the expected output (figure path, row counts) and visually verify
- See `.claude/rules/verification-protocol.md`

## Data provenance

The single dataset in this repo is a Kenya slice of ACLED (Armed Conflict Location & Event Data), filtered to 2010-2020 with a small subset of public columns. ACLED is freely available for academic use. See `data/README.md` for details.

## What this repo is NOT

- It is **not** a research output. No causal estimates, no headline findings, no identification strategy.
- It is **not** a replication package for any paper.
- It is **not** synced with any private project.

## License

All rights reserved — portfolio artifact for application review. See `LICENSE`.
