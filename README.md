# conflict_africa_demo — AI-Integrated Research Workflow Demo

A standalone demonstration of an AI-integrated empirical research workflow, built around a public ACLED conflict-event slice for Kenya, 2010-2020. This repo accompanies a pre-doctoral application and is intended to show:

1. **Reproducible R pipelines** with explicit verification steps
2. **AI workflow infrastructure** — custom rules, slash commands, and persistent memory used to collaborate with Claude Code
3. **Engineering discipline** in data cleaning, aggregation, and validation

> This is a public portfolio extract. No research findings are reproduced; the analysis stops at descriptive material.

## Quick tour

| What you're looking for | Where to find it |
|---|---|
| How I write reproducible R | [`code/`](code/) — numbered pipeline `d_01`-`d_04` |
| How I use AI in my workflow | [`docs/ai-workflow.md`](docs/ai-workflow.md) |
| Custom Claude Code rules | [`.claude/rules/`](.claude/rules/) |
| Custom slash commands | [`.claude/skills/`](.claude/skills/) |
| Persistent memory pattern | [`.claude/memory/MEMORY.md`](.claude/memory/MEMORY.md) |
| Pipeline overview | [`docs/architecture.md`](docs/architecture.md) |
| End-to-end runbook | [`CLAUDE.md`](CLAUDE.md) |

## What the pipeline does

```
d_01_acled_clean.R       Clean and deduplicate the raw ACLED Kenya CSV
                         → data/Conflict/ACLED/acled_kenya_clean.rds
d_02_acled_aggregate.R   Build a year x admin1 x event_type panel of
                         event counts and total fatalities
                         → data/Conflict/ACLED/acled_kenya_panel.rds
d_03_acled_check.R       11 verification checks (identity, key uniqueness,
                         count reconciliation, types, year coverage)
                         → exit 0 = pass
d_04_descriptive_figure.R  → output/figure_1_kenya_acled_events.png
```

## Run it

Requirements: R ≥ 4.2, packages: `here`, `readr`, `dplyr`, `tidyr`, `ggplot2`.

```bash
git clone https://github.com/wanzi-wang/conflict_africa_demo.git
cd conflict_africa_demo
Rscript code/d_01_acled_clean.R
Rscript code/d_02_acled_aggregate.R
Rscript code/d_03_acled_check.R          # → "11 PASS, 0 FAIL"
Rscript code/d_04_descriptive_figure.R    # → output/figure_1_kenya_acled_events.png
```

All paths are relative to the repo root. The pipeline is fully sandboxed.

## Why this matters for the application

The position asks for *"advanced ability to use modern AI tools for coding, data analysis, and research workflows."* This repo demonstrates:

- **Going beyond chat**: a structured `.claude/` directory with rules that enforce verification, plan-first workflow, and citation discipline; custom skills (`/spec`, `/review-r`, `/pipeline-debug`, `/docupdate`) that encode domain workflows; persistent memory that carries context across sessions.
- **AI-driven discipline**: real examples in [`docs/ai-workflow.md`](docs/ai-workflow.md) of how I use AI to catch silent bugs, design verification rules, and prevent black-box methodology adoption.
- **Reproducibility-first**: every data-construction script has an automated verifier; verification is treated as part of the code, not an afterthought.

## License

All rights reserved. Published for application review — see [`LICENSE`](LICENSE). Data is derived from public sources (ACLED) — see [`data/README.md`](data/README.md) for provenance.
