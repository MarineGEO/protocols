# Create seagrass data entry spreadsheets from schema

library(openxlsx)
library(tidyverse)

seagrass_schema <- read_csv("./seagrass/seagrass_schema.csv")

doi <- "10.25573/serc.14925114.v1"
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(seagrass_schema, "seagrass")
