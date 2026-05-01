# =============================================================================
# d_02_acled_aggregate.R  (DEMO)
# Aggregate the cleaned ACLED Kenya events into a year x admin1 x event_type
# panel of event counts and total fatalities.
#
# Input : data/Conflict/ACLED/acled_kenya_clean.rds
# Output: data/Conflict/ACLED/acled_kenya_panel.rds
#
# Run: Rscript code/d_02_acled_aggregate.R   (from repo root)
# =============================================================================

suppressPackageStartupMessages({
  library(here)
  library(dplyr)
  library(tidyr)
})

set.seed(20260501)

IN_FILE  <- here::here("data", "Conflict", "ACLED", "acled_kenya_clean.rds")
OUT_FILE <- here::here("data", "Conflict", "ACLED", "acled_kenya_panel.rds")

stopifnot(file.exists(IN_FILE))

events <- readRDS(IN_FILE)

panel <- events |>
  group_by(year, admin1, event_type) |>
  summarise(
    n_events         = dplyr::n(),
    total_fatalities = sum(fatalities, na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(year, admin1, event_type)

# ---- self-check ----
stopifnot(nrow(panel) > 0)
stopifnot(all(panel$n_events > 0L))
stopifnot(all(panel$total_fatalities >= 0L))
stopifnot(all(panel$year >= 2010L & panel$year <= 2020L))
key_dups <- panel |> count(year, admin1, event_type) |> filter(n > 1L)
stopifnot(nrow(key_dups) == 0L)

cat(sprintf("Panel rows:           %d\n", nrow(panel)))
cat(sprintf("Years covered:        %d - %d\n", min(panel$year), max(panel$year)))
cat(sprintf("Admin1 areas:         %d\n", dplyr::n_distinct(panel$admin1)))
cat(sprintf("Event types:          %d\n", dplyr::n_distinct(panel$event_type)))
cat(sprintf("Total events:         %d\n", sum(panel$n_events)))
cat(sprintf("Total fatalities:     %d\n", sum(panel$total_fatalities)))

saveRDS(panel, OUT_FILE)
cat("Wrote: ", OUT_FILE, "\n", sep = "")
