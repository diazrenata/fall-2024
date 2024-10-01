library(dplyr)
library(tidyr)
library(ggplot2)
library(palmerpenguins)

source("R/penguin_analysis_functions.R")

penguins <- penguins

# Workflow as functions

biscoe_data <- get_island_data(island_name = "Biscoe")
biscoe_predictions <- get_predicted_body_masses(biscoe_data)

# Now get the predictions for the other two islands

dream_data <- get_island_data(island_name = "Dream")
dream_predictions <- get_predicted_body_masses(dream_data)

torgersen_data <- get_island_data(island_name = "Torgersen")
torgersen_predictions <- get_predicted_body_masses(torgersen_data)

# Using iteration

### For loop to get the data

islands_data <- list()

for(an_island in c("Biscoe", "Dream", "Torgersen")) {
  islands_data[[an_island]] <- get_island_data(island_name = an_island)
}

### purrr::map to get the predictions

islands_predictions <- purrr::map(islands_data, get_predicted_body_masses)

island_predictions_df <- dplyr::bind_rows(islands_predictions)

