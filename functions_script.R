library(palmerpenguins)
library(dplyr)

source("R/measurement_conversions.R")

penguins <- penguins

head(penguins)

# Convert between metric and imperial measurements

# 39.1 mm in inches

39.1 * 0.03937008

# Convert any value in mm to inches

penguins_with_inches <- penguins |>
  mutate(across(ends_with("mm"), mm_to_inches, .names = "{.col}_in"))

penguins_rounded <- penguins |>
  mutate(across(ends_with("mm"), \(x) {round(x, digits = 1)}, .names = "{.col}_rounded"),
         across(ends_with("lb"), \(x) {round(x, digits = 2)}, .names = "{.col}_rounded"))

#### Create a function to return penguins data in metric or imperial ####

get_penguins_data <- function(units = "metric", penguins_data) {
  
  if(units == "metric") {
    return(penguins_data)
  } else if (units == "imperial") {
    penguins_imperial <- penguins_data |>
      mutate(across(ends_with("mm"), mm_to_inches, .names = "{.col}_in"),
             across(ends_with("g"), g_to_lbs, .names = "{.col}_lb"))
    
    return(penguins_imperial)
  } else {
    stop("Please specify units as either 'metric' or 'imperial'!")
  }
}

get_penguins_data(units = "metric", penguins_data = penguins)
get_penguins_data(units = "foo", penguins_data = penguins)
