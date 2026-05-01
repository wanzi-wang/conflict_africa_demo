---
name: pipeline-debug
description: Diagnose and fix R script errors from error messages or unexpected output
---

# Pipeline Debug

Diagnose and fix an R script error the user is encountering.

## Inputs
The user will paste an error message or describe unexpected output.

## Steps

1. **Read the error carefully.** Identify the script, line number, and error type.
2. **Read the relevant script** — the FULL function or section where the error occurs, not just the line.
3. **Check upstream.** If the error is about missing columns or wrong types, read the upstream script's output schema to understand what data is being passed in.
4. **Diagnose before fixing.** Explain the root cause in 1-2 sentences before proposing a fix.
5. **Fix rules:**
   - ONLY edit the file the user names or the file that threw the error
   - Include all necessary `library()` calls
   - Use `na.rm = TRUE` where appropriate
   - Test edge cases: empty data frames, NA values, type mismatches
6. **Propose a minimal fix.** Don't refactor surrounding code. Don't add features.
7. **Tell the user how to verify** — what to run and what output to expect.
