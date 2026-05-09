---
name: Project status — conflict_africa_demo
description: Standalone Kenya-ACLED demo repo; isolation rules in CLAUDE.md are non-negotiable
type: project
---

`conflict_africa_demo` is a public demonstration repo (May 2026). It is a self-contained 4-script ACLED aggregation pipeline (`d_01` clean -> `d_02` aggregate -> `d_03` check -> `d_04` figure), built around a Kenya 2010-2020 slice. Verifier `d_03` reports 11 PASS, 0 FAIL on the slice.

**Why:** The repo demonstrates reproducible-research and AI-workflow practices on a public dataset. It does not reveal any specific research methodology.

**How to apply:** Treat this repo as standalone. Do not couple it to any other project on disk. Isolation rules in `CLAUDE.md` are hard rules, not preferences.
