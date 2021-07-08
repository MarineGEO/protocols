# Create oyster data entry spreadsheet from schema

library(openxlsx)
library(tidyverse)

oyster_schema <- read_csv("./oyster/oyster_schema_single_spreadsheet_version.csv")

doi <- paste0("DOI: ", "10.25573/serc.14714328.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(oyster_schema, "oyster")
