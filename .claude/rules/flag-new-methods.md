# Flag New Methods

When introducing an econometric method, statistical technique, or analytical approach that has NOT been used in the project before, stop and flag it before writing any code.

## What to flag
- New estimators (e.g., Conley SEs, spatial HAC, IV, RDD, synthetic control)
- New packages or functions the user hasn't seen in this project
- Changes to how standard errors are computed
- New treatment variable constructions
- Any methodological choice that a coauthor would want to discuss

## How to flag
Before writing the code, explain in plain language:
1. **What** the method does (one sentence)
2. **Why** it's needed here — what problem does it solve that the current approach doesn't?
3. **What changes** in the output — will coefficients change? SEs? Inference?
4. **Trade-offs** — what does it cost (assumptions, computation, complexity)?

## Why
The user is building econometric intuition and needs to understand every method in their paper. A method they can't explain to their coauthor or a referee shouldn't be in the code. Flagging also prevents the user from running code they don't understand, which creates risk at the defense or referee stage.

## Do NOT flag
- Standard operations already in the pipeline (feols, att_gt, clustered SEs at cell level)
- Minor code changes that don't alter methodology
- Visualization choices
