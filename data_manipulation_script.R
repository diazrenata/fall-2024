library(dplyr)
library(tidyr)
library(palmerpenguins)
library(ggplot2)

penguins_data <- penguins

write.csv(penguins_data,
          "data/penguins.csv",
          row.names = FALSE)

head(penguins)
str(penguins)

new_object <- penguins_data

new_object <- penguins_data |>
  head()

# Subsetting data

# Select

penguin_locations <- penguins_data |>
  select(species, island)

penguin_mm_measurements <- penguins_data |>
  select(ends_with("mm"))

# Filter operates on rows

adelie_penguins <- penguins_data |>
  filter(species == "Adelie")

# Adding or modifying columns - "mutate"

penguins_ratio <- penguins_data |>
  mutate(bill_length_depth_ratio = bill_length_mm / bill_depth_mm)

penguins_rounded <- penguins_data |>
  mutate(bill_length_mm_rounded = round(bill_length_mm, digits = 2))

penguins_rounded <- penguins_data |>
  mutate(across(ends_with("mm"), round))

penguins_rounded <- penguins_data |>
  mutate(across(ends_with("mm"), round, .names = "{.col}_rounded"))

# Split-apply-combine

penguin_species_totals <- penguins_data |>
  group_by(species, island) |>
  summarize(total_penguins = n(),
            total_penguin_biomass = sum(body_mass_g, na.rm = TRUE)) |>
  ungroup()
