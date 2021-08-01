# Create sediment organic matter data entry spreadsheet from schema
# Requires R < v4.0

library(openxlsx)
library(tidyverse)

sedorg_schema <- read_csv("./sediment-organic-matter/sediment-organic-matter_schema.csv")

doi <- "10.25573/serc.14925111.v1"
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(sedorg_schema, "sediment-organic-matter")

