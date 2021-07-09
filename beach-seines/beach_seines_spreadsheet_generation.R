# Create beach seines data entry spreadsheet from schema
# Requires R < v4.0

library(openxlsx)
library(tidyverse)

beachseines_schema <- read_csv("./beach-seines/beach_seines_schema.csv")

doi <- paste0("DOI: ", "10.25573/serc.14925105.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(beachseines_schema, "beach-seines")