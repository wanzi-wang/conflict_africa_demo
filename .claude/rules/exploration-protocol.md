# Exploration Protocol

Experimental or exploratory analyses go in a sandbox before entering the pipeline.

## When to use
- Testing a new specification or identification strategy
- Trying a new visualization approach
- Exploring a data source not yet integrated
- Quick checks that don't belong in the numbered pipeline

## Where
- Save exploratory scripts to `code/exploratory/` (create if needed)
- Name format: `explore_<topic>_<date>.R` (e.g., `explore_spillover_rings_20260407.R`)
- Output files go to a temporary location, not the main data directories

## Graduation to pipeline
An exploratory script can become a pipeline script when:
1. The user decides the analysis belongs in the paper
2. The code meets R conventions (see r-code-conventions rule)
3. It has proper verification checks
4. It's assigned a pipeline number and integrated into `code/README.md`

## Key principle
Exploratory code is disposable. Pipeline code is permanent. Don't over-engineer explorations, and don't put rough code in the pipeline.
