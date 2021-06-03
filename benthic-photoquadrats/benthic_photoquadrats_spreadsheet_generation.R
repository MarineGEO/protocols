# Create sampling_event protocol from schema

library(openxlsx)
library(tidyverse)

benthic_photoquadrats_schema <- read_csv("./benthic-photoquadrats/benthic_photoquadrats_schema.csv")

doi <- paste0("DOI: ", "10.25573/serc.14717823.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(benthic_photoquadrats_schema, "benthic-photoquadrats")
