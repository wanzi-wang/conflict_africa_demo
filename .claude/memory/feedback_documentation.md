---
name: Documentation style
description: Concise, first-time-reader friendly; never include claims that aren't backed by data
type: feedback
---

Documentation should be readable cold by a stranger. Avoid jargon shorthand from earlier in the session. Source numerical claims from result CSVs or pipeline outputs — never fabricate or recall numbers from memory.

**Why:** A reviewer or coauthor who picks up the repo cold should be able to understand what's in it without me there to translate. Numbers in docs that don't match numbers in the data erode trust faster than missing documentation.

**How to apply:** When writing or updating README / architecture / handoff docs, verify every count, statistic, or status claim against the actual file or script output. If a number can't be verified, leave it out or mark it "approximate."
