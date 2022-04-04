# Create sampling_event protocol from schema

library(openxlsx)
library(tidyverse)

schema <- read_csv("./envlogger/envlogger_schema.csv")
doi <- "10.25573/serc.19153766.v3"
source("./scripts/spreadsheet_generation_functions.R")

generateSpreadsheets(schema, "envlogger")
  