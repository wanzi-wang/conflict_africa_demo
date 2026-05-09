# AI-integrated research workflow

This document describes how I use Claude Code in my research, with concrete vignettes that illustrate where AI added measurable value beyond a chat conversation. The vignettes are abstracted from real working sessions and reframed on the public ACLED slice that ships with this repo.

## The structural pieces

I use four layers of AI infrastructure on top of vanilla chat:

### 1. Rules (`.claude/rules/`)

Plain-text behavioral rules that Claude reads at the start of every session. They survive across conversations and across machines. Each rule is small (one page or less) and addresses one workflow risk. Examples in this repo:

- `plan-first.md` — Forces a written plan before any non-trivial code change. The cost of a 30-second plan review is far below the cost of rewriting a script that went the wrong direction.
- `verification-protocol.md` — Maps each script to its verifier. After every edit, Claude states the exact command to run and the pass criterion.
- `flag-new-methods.md` — Forces Claude to stop and explain in plain language whenever a new estimator or technique is about to be introduced. This protects against me running code I don't understand.
- `no-unverified-citations.md` — Bans citations from training-data recall. Claude must read the paper or have me confirm the claim first.

### 2. Skills (`.claude/skills/`)

Custom slash commands that encode multi-step workflows. Examples in this repo:

- `/spec` — Writes formal econometric specifications in code-block form before regression code is written. Forces alignment on what's being estimated.
- `/review-r` — Read-only audit of an R script across seven dimensions (style, I/O, NA handling, reproducibility, etc.).
- `/pipeline-debug` — Triage workflow for R errors, starting from the error message and moving outward.
- `/docupdate` — Re-syncs README and docs with current code state.

### 3. Persistent memory (`.claude/memory/`)

A file-based memory system that survives across sessions. Each entry is a small markdown file with frontmatter; an index in `MEMORY.md` lets Claude pull the right ones into context. I use four categories:

- **user**: who I am, what I'm trained in, how I want to be talked to
- **feedback**: corrections that should not need to be repeated
- **project**: current work state — what's done, what's pending, decisions made
- **reference**: pointers to external systems

Memory is what lets a session in May resume cleanly from where a session in March left off, without me having to re-orient Claude every time.

### 4. CLAUDE.md (per repo)

A short, directive file at the repo root that pins the most important rules for this specific codebase. In this demo, `CLAUDE.md` carries hard isolation rules: never read or write outside the repo. That single page is the safety net that keeps the demo sandboxed.

## Three vignettes

### Vignette 1: A silent direction-flip in a row-expansion step

**Context.** In a pipeline I worked on, a script expanded a record-period table into a long format using `seq(start_year, end_year)` row by row. For a small fraction of records, `start_year > end_year` because of an upstream data quirk. R's `seq()` does not error on a reversed range — it silently returns a *descending* sequence, which then expanded into rows with negative duration and nonsensical dates.

**How AI helped.** I asked Claude to review the expansion script for "row-count surprises." It immediately flagged the unguarded `seq()` call as a candidate, ran a small diagnostic on the input, and showed me which records were affected. The fix was a one-line filter before the `seq()` call. Without that audit, the bug would have lived in the output for months.

**The lesson encoded.** The `r-code-conventions.md` rule now says *"explicit `na.rm = TRUE` in all summary functions"* and *"never rely on global environment state."* The `verification-protocol.md` rule requires row-count consistency checks at every pipeline stage. In this demo, that pattern shows up as the `C01` check in `d_03_acled_check.R`: *the panel's `sum(n_events)` must equal the cleaned event table's `nrow()`*. If counts diverge, *something* is wrong, and the verifier surfaces it before any downstream analysis runs.

### Vignette 2: Designing a count-reconciliation check

**Context.** When I first wrote the aggregation step (`d_02_acled_aggregate.R`), I had no automated check that the resulting panel was complete. A subtle bug — a `group_by` that silently drops NA keys, an upstream filter that runs after a summary, a join that explodes because of unintended duplicate keys — could quietly produce a panel that *looked* fine but lost rows.

**How AI helped.** I asked Claude what kinds of bugs typically corrupt aggregations without throwing errors. It walked through three classes (silent NA drops, key duplications, filter-vs-summarise order) and then proposed a single check that catches all three: reconcile the sum of `n_events` against the row count of the input. We added it as `C01`, and it has fired several times in development on a slightly different version of the script — once because of an NA in `admin1`, once because the input file had been re-saved without dedup. Both bugs would have been invisible without the check.

**The lesson encoded.** The `d_03_acled_check.R` script and the verifier pattern in `verification-protocol.md` came directly out of this work. The principle is that *every aggregation should have a check that ties its output back to its input by an arithmetic identity*. If the identity holds, the aggregation is at least dimensionally sound.

### Vignette 3: Codifying a methodology-flag rule

**Context.** I'm a master's student who can read econometrics papers but can't always derive methods from scratch. There was a temptation to let Claude introduce techniques (Conley standard errors, spatial HAC, IV) without me understanding them deeply enough to defend.

**How AI helped — backwards.** I asked Claude to *help me write a rule that would prevent this pattern*. We iterated on `flag-new-methods.md` until it captured the four things I actually want to hear before adopting a new method: what it does in one sentence, why it solves a problem the current approach doesn't, what changes in the output, and what the trade-offs are. Now whenever Claude proposes a new estimator, it's required to deliver that briefing before writing code.

**The lesson encoded.** This is the meta-pattern: **AI is most useful when you use it to encode your own discipline.** The rule isn't telling Claude what *Claude* should know — it's telling Claude what *I* need to be confronted with before I let new code into the pipeline. The same principle drives `no-unverified-citations.md` (preventing fabricated references) and `plan-first.md` (preventing sprint-then-rewrite cycles).

## Takeaways

The R code in `code/` is fine but unremarkable on its own — it's a four-step ACLED aggregation with checks. What's distinctive is the scaffolding around it:

- A `.claude/` directory that turns Claude Code from a chatbot into a project-aware collaborator
- A verification-first pipeline where every data-construction script has a verifier and the verifier exits a known code
- A memory system that carries judgment from one session to the next
- A working pattern of *"AI catches a bug class → I write a rule that prevents the next instance"*
