# Create salt marsh data entry spreadsheet from schema
# Requires R < v4.0

library(openxlsx)
library(tidyverse)

saltmarsh_schema <- read_csv("./saltmarsh/saltmarsh_schema.csv")

doi <- paste0("DOI: ", "10.25573/serc.14896194.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(saltmarsh_schema, "saltmarsh")

