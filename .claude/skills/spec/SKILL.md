---
name: spec
description: Show formal econometric specification before writing regression code
---

# Econometric Specification

Show the formal econometric specification for an analysis before writing any code.

## Steps

1. **Ask what the user wants to estimate** if not already clear (outcome, treatment, unit of observation, identification strategy).
2. **Write the formal specification** in a code block using standard notation:
   - Y_{it} for outcomes, D_{it} for treatment, X_{it} for controls
   - Greek letters for parameters (β, γ, δ, α)
   - Define EVERY subscript, variable, and term
   - State the estimator (OLS, CS DiD, etc.)
   - State the standard error clustering
3. **State the identifying assumption** — what must be true for the estimate to be causal?
4. **Flag any concerns** — pre-trends, SUTVA violations, staggered timing issues, bad controls.
5. **Only after the user approves**, write the R code implementing that exact specification.
6. **Use project conventions:** `fixest` for OLS/TWFE, `did` for Callaway & Sant'Anna, star convention *** p<0.01 ** p<0.05 * p<0.10.
