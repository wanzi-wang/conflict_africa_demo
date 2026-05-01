# =============================================================================
# d_04_descriptive_figure.R  (DEMO)
# Produce a public descriptive figure for the Kenya slice:
# annual ACLED conflict event counts in Kenya by event type, 2010-2020.
#
# Input:  data/Conflict/ACLED/acled_kenya_panel.rds
# Output: output/figure_1_kenya_acled_events.png
# =============================================================================

suppressPackageStartupMessages({
  library(here)
  library(dplyr)
  library(ggplot2)
})

set.seed(20260501)

PANEL_FILE <- here::here("data", "Conflict", "ACLED", "acled_kenya_panel.rds")
OUT_FILE   <- here::here("output", "figure_1_kenya_acled_events.png")

stopifnot(file.exists(PANEL_FILE))

panel <- readRDS(PANEL_FILE)

annual <- panel |>
  group_by(year, event_type) |>
  summarise(n_events = sum(n_events), .groups = "drop")

# ---- self-check ----
stopifnot(nrow(annual) > 0)
stopifnot(all(annual$year >= 2010L & annual$year <= 2020L))
stopifnot(all(!is.na(annual$n_events)))
cat(sprintf("Annual rows: %d ; total events: %d\n",
            nrow(annual), sum(annual$n_events, na.rm = TRUE)))

# ---- figure ----
p <- ggplot(annual, aes(x = year, y = n_events, fill = event_type)) +
  geom_col(position = "stack") +
  scale_x_continuous(breaks = 2010:2020) +
  labs(
    title = "ACLED conflict events in Kenya, 2010-2020",
    subtitle = "Annual counts by event type (illustrative slice)",
    x = NULL, y = "Number of events", fill = "Event type",
    caption = "Source: ACLED (academic access). Demo slice."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title.position = "plot",
    panel.grid.minor = element_blank()
  )

dir.create(dirname(OUT_FILE), showWarnings = FALSE, recursive = TRUE)
ggsave(OUT_FILE, plot = p, width = 8, height = 5, dpi = 150, bg = "white")
cat("Wrote: ", OUT_FILE, "\n", sep = "")
