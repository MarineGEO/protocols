# Create sampling_event protocol from schema

library(openxlsx)
library(tidyverse)

predation_assay_schema <- read_csv("./predation-assay/predation_assay_schema.csv")

doi <- "10.25573/serc.14717802.v1"
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(predation_assay_schema, "predation-assay")
