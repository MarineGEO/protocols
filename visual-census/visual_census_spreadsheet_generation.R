# Create sampling_event protocol from schema

library(openxlsx)
library(tidyverse)

visual_census_schema <- read_csv("./visual-census/visual_census_schema.csv")

doi <- "10.25573/serc.14717796.v1"
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(visual_census_schema, "visual-census")

