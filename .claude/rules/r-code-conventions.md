# R Code Conventions

These conventions apply to ALL R scripts in this project.

## Style
- **snake_case** for all variable and function names
- 100-character line width maximum
- `library()` calls at top of every script, never inside functions
- Use `<-` for assignment, never `=`
- Use `|>` (base pipe) unless a script already uses `%>%` consistently

## Data I/O
- Read Excel: `readxl::read_xlsx()` (never `read.xlsx`)
- Read OCR / mixed-type tables with `col_types = "text"` to avoid silent coercion
- Save intermediate outputs as `.rds` files via `saveRDS()` / `readRDS()`
- Never write CSV for intermediate pipeline data (lose types)
- Credentials via `~/.Renviron`; never hard-code keys
- All paths relative to repo root via `here::here()` — never absolute paths

## Reproducibility
- `set.seed(YYYYMMDD)` before any random operation (date of initial implementation)
- Explicit `na.rm = TRUE` in all summary functions
- Never rely on global environment state — each script should be runnable standalone

## Packages
- `here` for path management
- `sf` for spatial operations
- `data.table` or `dplyr` for data manipulation (match existing script style)
- `readxl` / `readr` for I/O
- `ggplot2` for figures

## Figures
- Default size: 12 x 5 inches for wide panels, 8 x 6 for single plots
- White background (`theme_minimal()` base)
- Save as both `.png` (for quick viewing) and `.pdf` (for paper)
- Colorblind-friendly palettes preferred

## Stars Convention
- `*** p<0.01, ** p<0.05, * p<0.10`
- Always cluster standard errors — state the clustering level in output
