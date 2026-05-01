# Data — ACLED Kenya slice

This folder contains a single small public dataset: a Kenya-only slice of ACLED conflict events, 2010-2020.

## Contents

| Path | Source | Slice criteria | Size |
|---|---|---|---|
| `Conflict/ACLED/acled_kenya_2010_2020.csv` | ACLED — Armed Conflict Location & Event Data | `country == "Kenya"`, 2010-2020, slim columns | ~727 KB |
| `Conflict/ACLED/acled_kenya_clean.rds` | Built by `d_01_acled_clean.R` | regenerable | ~tens of KB |
| `Conflict/ACLED/acled_kenya_panel.rds` | Built by `d_02_acled_aggregate.R` | regenerable | ~tens of KB |

## Provenance

ACLED data is freely available for academic use. The slice here keeps a small subset of public columns (`event_id_cnty`, `event_date`, `year`, `event_type`, `sub_event_type`, `actor1`, `actor2`, `country`, `admin1`, `admin2`, `location`, `latitude`, `longitude`, `fatalities`) and is shown for illustrative purposes only.

Original terms: <https://acleddata.com/terms-of-use/>

## Building the slice

The raw CSV here was filtered from the ACLED Africa snapshot using:

```r
library(dplyr); library(readr)
acled <- readRDS("path/to/acled_africa.rds")
ke <- acled |>
  filter(country == "Kenya",
         format(as.Date(event_date), "%Y") >= "2010",
         format(as.Date(event_date), "%Y") <= "2020") |>
  select(event_id_cnty, event_date, year, event_type, sub_event_type,
         actor1, actor2, country, admin1, admin2, location,
         latitude, longitude, fatalities)
write_csv(ke, "data/Conflict/ACLED/acled_kenya_2010_2020.csv")
```

The filter expression is documented here for transparency. The script that performed the filter does not live in this repo because it would necessarily reference paths outside the repo root, violating the isolation rules in `CLAUDE.md`.
