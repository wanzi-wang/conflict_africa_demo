---
name: review-r
description: R code quality review — read-only audit of a script across 7 dimensions
---

# R Code Review

Perform a thorough, read-only review of an R script.

## Inputs
The user specifies the script (e.g., `/review-r 14_distance_prep.R`).

## Steps

1. **Read the full script.** Do not skim — read every line.
2. **Read upstream and downstream scripts** to understand data flow:
   - What does this script receive as input? Check the .rds it reads.
   - What does this script produce? Check what downstream scripts expect.
3. **Review across 7 categories** (score each 1-5):
   - Correctness — does it do what it claims?
   - Reproducibility — standalone, deterministic, set.seed?
   - Data integrity — NA handling, type safety, column checks?
   - Econometric validity — specification matches intent, correct SEs, treatment timing?
   - Pipeline integration — input/output schemas consistent?
   - Code clarity — readable by coauthor on first pass?
   - Performance — efficient on 309K+ row panel?
4. **Produce the review report** using the format from the r-reviewer agent.
5. **Do NOT edit any files.** This is a read-only review.
6. **Prioritize findings:** Critical (must fix before running) > Recommendations > Minor.

## When to use
- Before running a new or heavily modified script for the first time
- When the user wants a second opinion on code quality
- As part of preparing scripts for the paper's replication package
