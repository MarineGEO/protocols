# Create PANEL data entry spreadsheet from schema

library(openxlsx)
library(tidyverse)

panels_schema <- read_csv("./panels/panels_schema.csv")
doi <- "" #paste0("DOI: ", "10.25573/serc.14510649.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(panels_schema, "panels")
