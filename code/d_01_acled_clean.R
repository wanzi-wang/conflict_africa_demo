# =============================================================================
# d_01_acled_clean.R  (DEMO)
# Clean and standardize the Kenya ACLED slice.
#
# Input : data/Conflict/ACLED/acled_kenya_2010_2020.csv
# Output: data/Conflict/ACLED/acled_kenya_clean.rds
#
# What this script does:
#   1. Read the raw slice as character (no silent type coercion)
#   2. Coerce typed columns explicitly (date, year, fatalities, lat, lon)
#   3. Drop duplicates on event_id_cnty
#   4. Drop rows with missing event_date, coords, or country
#   5. Restrict to Kenya, 2010-2020
#   6. Self-check the output
#
# Run: Rscript code/d_01_acled_clean.R   (from repo root)
# =============================================================================

suppressPackageStartupMessages({
  library(here)
  library(readr)
  library(dplyr)
})

set.seed(20260501)

IN_FILE  <- here::here("data", "Conflict", "ACLED", "acled_kenya_2010_2020.csv")
OUT_FILE <- here::here("data", "Conflict", "ACLED", "acled_kenya_clean.rds")

stopifnot(file.exists(IN_FILE))

raw <- read_csv(IN_FILE, show_col_types = FALSE,
                col_types = cols(.default = col_character()))

n_raw <- nrow(raw)

clean <- raw |>
  mutate(
    event_date = as.Date(event_date),
    year       = as.integer(year),
    fatalities = as.integer(fatalities),
    latitude   = as.numeric(latitude),
    longitude  = as.numeric(longitude)
  ) |>
  distinct(event_id_cnty, .keep_all = TRUE) |>
  filter(
    !is.na(event_date),
    !is.na(latitude), !is.na(longitude),
    country == "Kenya",
    year >= 2010L, year <= 2020L
  )

# ---- self-check ----
stopifnot(nrow(clean) > 0)
stopifnot(all(clean$country == "Kenya"))
stopifnot(all(clean$year >= 2010L & clean$year <= 2020L))
stopifnot(!any(duplicated(clean$event_id_cnty)))
stopifnot(all(!is.na(clean$latitude) & !is.na(clean$longitude)))

dropped <- n_raw - nrow(clean)
cat(sprintf("Raw rows:     %d\n", n_raw))
cat(sprintf("Clean rows:   %d  (dropped %d)\n", nrow(clean), dropped))
cat(sprintf("Years:        %d - %d\n", min(clean$year), max(clean$year)))
cat(sprintf("Admin1 areas: %d\n", dplyr::n_distinct(clean$admin1)))
cat(sprintf("Event types:  %d\n", dplyr::n_distinct(clean$event_type)))

dir.create(dirname(OUT_FILE), showWarnings = FALSE, recursive = TRUE)
saveRDS(clean, OUT_FILE)
cat("Wrote: ", OUT_FILE, "\n", sep = "")
