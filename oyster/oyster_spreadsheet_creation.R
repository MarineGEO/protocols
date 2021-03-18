# Create oyster protocol from schema

library(openxlsx)
library(tidyverse)

oyster_schema <- read_csv("./oyster/oyster_schema.csv")

for(protocol in unique(oyster_schema$protocol_name)){

  wb <- loadWorkbook(file = "./resources/data_entry_spreadsheet_template.xlsx")
  
  for(table in unique(oyster_schema$sheet_name)){
    
    protocol_schema <- oyster_schema %>%
      filter(protocol_name == protocol,
             sheet_name == table)
    
    addWorksheet(wb, sheetName = table)
    
    num_col <- length(protocol_schema$field_name)
    
    df <- setNames(data.frame(matrix(ncol = num_col, nrow = 0)), protocol_schema$field_name)
   
    col_style <- createStyle(
      fontName = "Calibri",
      fontSize = 11,
      fontColour = "black",
      textDecoration = "bold",
      #numFmt = "GENERAL",
      border = NULL,
      borderColour = getOption("openxlsx.borderColour", "black"),
      borderStyle = getOption("openxlsx.borderStyle", "thin"),
      #bgFill = "indexed: 64",
      fgFill = "#C7EAFE",
      halign = "center",
      valign = NULL,
      wrapText = FALSE,
      textRotation = NULL,
      indent = NULL,
      locked = NULL,
      hidden = NULL
    )
    
    writeData(wb, sheet = table, x = df, withFilter = F,
              headerStyle = col_style)#getStyles(test_style)[[1]])
    
    setColWidths(wb, sheet = table, cols = 1:num_col, widths = "auto")
    
  }
  
  filename = paste0("./oyster/", protocol, "_marinegeo_protocol.xlsx")
  
  saveWorkbook(wb, file = filename, overwrite = T)
  
}
# Test with just one protocol
# protocol_name <- "oyster reef area and height"
# sheet_name <- "sample metadata"
# 
# protocol_schema <- oyster_schema %>%
#   filter(protocol_name == protocol_name,
#          sheet_name == "sample metadata")
# 
# wb <- loadWorkbook(file = "./resources/data_entry_spreadsheet_template.xlsx")
# 
# addWorksheet(wb, sheetName = sheet_name)
# 
# num_col <- length(protocol_schema$field_name)
# 
# df <- setNames(data.frame(matrix(ncol = num_col, nrow = 0)), protocol_schema$field_name)

# Plain, no styling
# writeDataTable(wb, sheet = protocol_name, x = df, withFilter = F,
#                tableStyle = "none")
# 
# saveWorkbook(wb, file = "./oyster/oyster_data_entry_spreadsheet_test.xlsx", overwrite = T)

# Load in properly formated table to check styles
# test_style <- loadWorkbook(file = "./resources/test_styles.xlsx")

# Style for header:
# A custom cell style. 
# 
# Cell formatting: GENERAL 
# Font name: Calibri 
# Font size: 11 
# Font colour: 1 
# Font decoration: BOLD 
# Cell horz. align: center 
# Cell fill foreground:  rgb: #C7EAFE 
# Cell fill background:  indexed: 64 
# wraptext: TRUE 

# col_style <- createStyle(
#   fontName = "Calibri",
#   fontSize = 11,
#   fontColour = "black",
#   textDecoration = "bold",
#   #numFmt = "GENERAL",
#   border = NULL,
#   borderColour = getOption("openxlsx.borderColour", "black"),
#   borderStyle = getOption("openxlsx.borderStyle", "thin"),
#   #bgFill = "indexed: 64",
#   fgFill = "#C7EAFE",
#   halign = "center",
#   valign = NULL,
#   wrapText = FALSE,
#   textRotation = NULL,
#   indent = NULL,
#   locked = NULL,
#   hidden = NULL
# )

writeData(wb, sheet = sheet_name, x = df, withFilter = F,
               headerStyle = col_style)#getStyles(test_style)[[1]])

setColWidths(wb, sheet = sheet_name, cols = 1:num_col, widths = "auto")

saveWorkbook(wb, file = "./oyster/oyster_data_entry_spreadsheet_test.xlsx", overwrite = T)
