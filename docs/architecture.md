# Pipeline architecture

This is a numbered R pipeline. Each stage reads from one well-defined input and writes to one well-defined output. The verifier (`d_03`) re-reads those outputs and exits non-zero on any logic error.

```
   ┌────────────────────────────────────────────────────┐
   │ data/Conflict/ACLED/acled_kenya_2010_2020.csv      │
   │ public ACLED slice, 5,216 events                   │
   └─────────────────┬──────────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────┐
        │ d_01_acled_clean.R         │  read as character; coerce types;
        │                            │  dedupe on event_id_cnty;
        │                            │  drop missing date / coords;
        │                            │  restrict to Kenya 2010-2020
        └────────────────┬───────────┘
                         │  data/Conflict/ACLED/acled_kenya_clean.rds
                         ▼
        ┌────────────────────────────┐
        │ d_02_acled_aggregate.R     │  group_by(year, admin1, event_type);
        │                            │  summarise n_events, total_fatalities
        └────────────────┬───────────┘
                         │  data/Conflict/ACLED/acled_kenya_panel.rds
                         ▼
        ┌────────────────────────────┐
        │ d_03_acled_check.R         │  11 named checks across 5 groups:
        │                            │   I01-I02 identity
        │                            │   K01-K02 key integrity
        │                            │   C01-C04 count reconciliation
        │                            │   T01-T02 column types
        │                            │   Y01     year coverage
        │                            │  exit 0 on PASS, 1 on any FAIL
        └────────────────┬───────────┘
                         │
                         ▼
        ┌────────────────────────────┐
        │ d_04_descriptive_figure.R  │  collapse panel to year x event_type;
        │                            │  stacked bar plot
        └────────────────┬───────────┘
                         │
                         ▼
            output/figure_1_kenya_acled_events.png
```

## Verifier philosophy

`d_03_acled_check.R` is designed to be runnable as the *only* signal a reviewer needs:

- **PASS** — invariant held
- **WARN** — needs human review (printed inline)
- **FAIL** — logic error in upstream script; sets exit status 1

A non-zero exit code is treated as a hard stop. This is enforced by the project rule `verification-protocol.md`.

## Why count reconciliation matters

The most subtle data-construction bugs are silent ones: a `group_by` that drops rows because of an unnoticed NA, a join that explodes because of unintended duplicate keys, a filter that runs *after* a summary instead of before. The check `C01` — *the panel's `sum(n_events)` must equal the cleaned event table's `nrow()`* — catches all three classes at once. If counts diverge, *something* is wrong, and the verifier surfaces it before any downstream analysis runs.
