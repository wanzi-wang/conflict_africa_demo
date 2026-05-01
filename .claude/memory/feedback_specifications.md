---
name: Show specifications before regression code
description: Always show the formal econometric specification in a code block before writing regression code
type: feedback
---

Before writing any regression / DiD / IV code, show the formal specification in a fenced code block, with each term defined.

**Why:** I'm building econometric intuition and need to understand what's being estimated before I look at output. Code that runs but estimates the wrong specification is harder to catch than code that doesn't run.

**How to apply:** When the user asks for a regression, IV, DiD, or similar estimator, output the equation first (e.g., $Y_{it} = \alpha_i + \gamma_t + \beta D_{it} + \varepsilon_{it}$ with terms defined), wait for confirmation, then write the code. The `/spec` skill formalizes this pattern.
