library(dplyr)
library(tidyr)
library(palmerpenguins)
library(ggplot2)

penguins_data <- penguins

write.csv(penguins_data, "data/penguins.csv", row.names = FALSE)

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
  summarize(
    total_penguins = n(),
    total_penguin_biomass = sum(body_mass_g, na.rm = TRUE)
  ) |>
  ungroup()

# Reshaping data

penguins_site_by_species <- penguin_species_totals |>
  select(species, island, total_penguins)

penguins_site_by_species <- penguin_species_totals |>
  select(species, island, total_penguins) |>
  tidyr::pivot_wider(
    id_cols = island,
    names_from = species,
    values_from = total_penguins,
    values_fill = 0
  )

penguins_back_to_totals <- penguins_site_by_species |>
  tidyr::pivot_longer(-island, 
                      names_to = "Species", 
                      values_to = "Abundance")

# Joins 

island_coordinates <- data.frame(
  island = c("Biscoe", "Dream", "Torgersen"),
  latitude = c(-65.433, -64.733, -64.766),
  longitude = c(-65.5, -64.344, -64.083)
)

penguins_coords <- left_join(penguins_data, island_coordinates)



ggplot(penguins_coords, aes(longitude, latitude, size = body_mass_g, color = species)) +
  geom_jitter(alpha = .3) +
  scale_color_viridis_d(option = "mako", begin = .2, end = .8)


ggplot(penguins_coords, aes(latitude, body_mass_g, color = species)) +
  geom_jitter() +
  scale_color_viridis_d(option = "mako", begin = .2, end = .8)
