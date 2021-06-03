# Create sampling_event protocol from schema

library(openxlsx)
library(tidyverse)

ulva_assay_schema <- read_csv("./ulva-assay/ulva_assay_schema.csv")

doi <- paste0("DOI: ", "10.25573/serc.14717808.v1")
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(ulva_assay_schema, "ulva-assay")