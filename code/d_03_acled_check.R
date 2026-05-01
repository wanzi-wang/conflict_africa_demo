# =============================================================================
# d_03_acled_check.R  (DEMO)
# Automated validation of the ACLED Kenya panel built by d_02_acled_aggregate.R.
#
# Checks are grouped:
#   I01-I02 : Identity      — input files exist and load
#   K01-K02 : Key integrity — uniqueness on (year, admin1, event_type)
#   C01-C04 : Counts        — totals reconcile with the cleaned event table
#   T01-T02 : Types         — column types and value ranges
#   Y01     : Year coverage — 2010 - 2020
#
# Each check prints PASS / WARN / FAIL.
# Exit code is non-zero if any FAIL fires.
#
# Run: Rscript code/d_03_acled_check.R   (from repo root)
# =============================================================================

suppressPackageStartupMessages({
  library(here)
  library(dplyr)
})

CLEAN_FILE <- here::here("data", "Conflict", "ACLED", "acled_kenya_clean.rds")
PANEL_FILE <- here::here("data", "Conflict", "ACLED", "acled_kenya_panel.rds")

n_fail <- 0L
n_warn <- 0L
n_pass <- 0L

pass <- function(id, msg) {
  cat(sprintf("  PASS  %s: %s\n", id, msg)); n_pass <<- n_pass + 1L
}
warn <- function(id, msg) {
  cat(sprintf("  WARN  %s: %s\n", id, msg)); n_warn <<- n_warn + 1L
}
fail <- function(id, msg) {
  cat(sprintf("  FAIL  %s: %s\n", id, msg)); n_fail <<- n_fail + 1L
}

cat("=== IDENTITY ===\n")
if (file.exists(CLEAN_FILE)) {
  pass("I01", "cleaned events file exists")
} else {
  fail("I01", sprintf("missing %s — run d_01_acled_clean.R first", CLEAN_FILE))
  quit(status = 1L)
}
if (file.exists(PANEL_FILE)) {
  pass("I02", "aggregated panel file exists")
} else {
  fail("I02", sprintf("missing %s — run d_02_acled_aggregate.R first", PANEL_FILE))
  quit(status = 1L)
}

events <- readRDS(CLEAN_FILE)
panel  <- readRDS(PANEL_FILE)

cat("\n=== KEY INTEGRITY ===\n")
key_dups <- panel |>
  count(year, admin1, event_type) |>
  filter(n > 1L)
if (nrow(key_dups) == 0L) {
  pass("K01", "(year, admin1, event_type) is unique")
} else {
  fail("K01", sprintf("%d duplicate keys", nrow(key_dups)))
}
if (!any(is.na(panel$year)) &&
    !any(is.na(panel$admin1)) &&
    !any(is.na(panel$event_type))) {
  pass("K02", "no NA in key columns")
} else {
  fail("K02", "NA values present in key columns")
}

cat("\n=== COUNTS ===\n")
n_events_panel <- sum(panel$n_events)
n_events_clean <- nrow(events)
if (n_events_panel == n_events_clean) {
  pass("C01", sprintf("event counts reconcile (%d == %d)",
                      n_events_panel, n_events_clean))
} else {
  fail("C01", sprintf("event counts diverge: panel=%d, clean=%d",
                      n_events_panel, n_events_clean))
}
fat_panel <- sum(panel$total_fatalities)
fat_clean <- sum(events$fatalities, na.rm = TRUE)
if (fat_panel == fat_clean) {
  pass("C02", sprintf("fatality totals reconcile (%d == %d)", fat_panel, fat_clean))
} else {
  fail("C02", sprintf("fatality totals diverge: panel=%d, clean=%d",
                      fat_panel, fat_clean))
}
if (all(panel$n_events > 0L)) {
  pass("C03", "no zero or negative event counts")
} else {
  fail("C03", "zero or negative event counts present")
}
if (all(panel$total_fatalities >= 0L)) {
  pass("C04", "no negative fatality totals")
} else {
  fail("C04", "negative fatality totals present")
}

cat("\n=== TYPES ===\n")
if (is.integer(panel$year) && is.integer(panel$n_events) &&
    is.integer(panel$total_fatalities)) {
  pass("T01", "year, n_events, total_fatalities are integer")
} else {
  warn("T01", "expected integer columns are not all integer")
}
if (is.character(panel$admin1) && is.character(panel$event_type)) {
  pass("T02", "admin1 and event_type are character")
} else {
  warn("T02", "admin1 / event_type unexpected type")
}

cat("\n=== YEAR COVERAGE ===\n")
yrs <- sort(unique(panel$year))
if (min(yrs) >= 2010L && max(yrs) <= 2020L) {
  pass("Y01", sprintf("year range %d - %d (within 2010 - 2020)",
                      min(yrs), max(yrs)))
} else {
  fail("Y01", sprintf("year range %d - %d outside 2010 - 2020",
                      min(yrs), max(yrs)))
}

cat("\n===================================\n")
cat(sprintf("RESULTS: %d PASS, %d WARN, %d FAIL\n", n_pass, n_warn, n_fail))
cat("===================================\n")
if (n_fail > 0L) quit(status = 1L) else quit(status = 0L)
