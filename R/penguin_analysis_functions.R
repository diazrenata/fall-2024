get_island_data <- function(island_name = "Biscoe") {
  
  this_island_data <- penguins |>
    filter(island == island_name) |>
    filter(!is.na(sex),
           !is.na(body_mass_g))
  
  return(this_island_data)
  
}

get_predicted_body_masses <- function(island_data) {
  
  if(length(unique(island_data$species)) > 1) {
    # Fits a linear model of body_mass_g ~ sex + species + sex:species
    island_lm <- lm(body_mass_g ~ sex * species,
                    data = island_data)
  } else {
    island_lm <- lm(body_mass_g ~ sex,
                    data = island_data)
  }
  
  # Extracting the predicted values from the linear model
  island_lm_predictions <- island_data |>
    select(island, sex, species) |>
    distinct() 
  
  island_lm_predictions <- island_lm_predictions |>
    mutate(predicted = predict(island_lm, newdata = island_lm_predictions))
  
  # Return the predictions
  
  return(island_lm_predictions)
  
}