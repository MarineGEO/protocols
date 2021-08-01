# Create fouling protocol from schema

library(openxlsx)
library(tidyverse)

fouling_schema <- read_csv("./fouling/fouling_community_schema.csv")
doi <- "10.25573/serc.14510649.v1"
source("./scripts/spreadsheet_generation_functions.R")

# First arg: name of schema object
# Second arg: name of protocol in filepath of repository
# MAKE SURE "final_spreadsheets" DIRECTORY EXISTS

generateSpreadsheets(fouling_schema, "fouling")

# metadata_definitions <- read_csv("./resources/marinegeo_metadata_glossary.csv")
# 
# for(protocol in unique(fouling_schema$protocol_name)){
# 
#   wb <- loadWorkbook(file = "./resources/data_entry_spreadsheet_template.xlsx")
#   
#   writeData(wb, sheet = 1, x = toupper(protocol), xy = c(2,1))
#   
#   protocol_tables <- fouling_schema %>%
#     filter(protocol_name == protocol) %>%
#     pull(sheet_name)
#   
#   glossary_raw <- fouling_schema %>%
#     filter(protocol_name == protocol) %>%
#     select(-protocol_name, -field_sheet_notes) 
#   
#   organize_glossary <- glossary_raw %>%
#     group_by(field_name) %>%
#     summarize(table_name_summary = paste(sheet_name, collapse = ", ")) %>%
#     arrange(field_name) 
#   
#   final_glossary <- merge(organize_glossary, metadata_definitions, by="field_name", all.x=T, all.y=F) %>%
#     select(field_name, definition, field_type, format_text, unit, table_name_summary)
#   
#   writeData(wb, sheet = 1, x = toupper(protocol), xy = c(2,1))
#   
#   writeData(wb, sheet = 1, x = final_glossary, xy = c(1, 4), colNames = F, borders = "all", borderStyle = "thin")
#   
#   glossary_style <- createStyle(wrapText = TRUE)
#   
#   addStyle(wb, sheet = 1, glossary_style, rows = 4:(4+nrow(final_glossary)), cols = 1:6, gridExpand = T, stack = T)
#   
#   for(table in unique(protocol_tables)){
#     
#     protocol_schema <- fouling_schema %>%
#       filter(protocol_name == protocol,
#              sheet_name == table)
#     
#     addWorksheet(wb, sheetName = table)
#     
#     num_col <- length(protocol_schema$field_name)
#     
#     df <- setNames(data.frame(matrix(ncol = num_col, nrow = 0)), protocol_schema$field_name)
#     
#     if("data_collection_year" %in% colnames(df)){
#       df <- df %>%
#         select(data_collection_year, data_collection_month, data_collection_day, everything())
#     }
#    
#     col_style <- createStyle(
#       fontName = "Calibri",
#       fontSize = 11,
#       fontColour = "black",
#       textDecoration = "bold",
#       #numFmt = "GENERAL",
#       border = NULL,
#       borderColour = getOption("openxlsx.borderColour", "black"),
#       borderStyle = getOption("openxlsx.borderStyle", "thin"),
#       #bgFill = "indexed: 64",
#       fgFill = "#C7EAFE",
#       halign = "center",
#       valign = NULL,
#       wrapText = FALSE,
#       textRotation = NULL,
#       indent = NULL,
#       locked = NULL,
#       hidden = NULL
#     )
#     
#     writeData(wb, sheet = table, x = df, withFilter = F,
#               headerStyle = col_style)#getStyles(test_style)[[1]])
#     
#     setColWidths(wb, sheet = table, cols = 1:num_col, widths = "auto")
#     
#   }
#   
#   filename = paste0("./fouling/final_spreadsheets/", protocol, "_marinegeo_protocol.xlsx")
#   
#   saveWorkbook(wb, file = filename, overwrite = T)
#   
# }

