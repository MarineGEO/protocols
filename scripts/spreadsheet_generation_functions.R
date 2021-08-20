generateSpreadsheets <- function(schema, protocol_filename){
  
  metadata_definitions <- read_csv("./resources/marinegeo_metadata_glossary.csv")
  
  for(protocol in unique(schema$protocol_name)){
    
    wb <- loadWorkbook(file = "./resources/data_entry_spreadsheet_template.xlsx")
    
    writeData(wb, sheet = 1, x = toupper(protocol), xy = c(2,1))
    
    protocol_tables <- schema %>%
      filter(protocol_name == protocol) %>%
      pull(sheet_name)
    
    glossary_raw <- schema %>%
      filter(protocol_name == protocol) %>%
      select(-protocol_name) 
    
    full_dictionary <- glossary_raw %>%
      filter(!field_name %in% metadata_definitions$field_name) %>%
      bind_rows(metadata_definitions) %>%
      select(-sheet_name) %>%
      distinct()
    
    organize_glossary <- glossary_raw %>%
      group_by(field_name) %>%
      summarize(table_name_summary = paste(sheet_name, collapse = ", ")) %>%
      arrange(field_name) 
    
    final_glossary_full_cols <- merge(organize_glossary, full_dictionary, by="field_name", all.x=T, all.y=F) 
    
    final_glossary <- final_glossary_full_cols %>%
      select(field_name, definition, field_type, format_text, unit, table_name_summary) 
    
    writeData(wb, sheet = 1, x = toupper(protocol), xy = c(2,1))
    
    doi_style <- createStyle(
      fontSize = 12,
      valign = "bottom",
      textDecoration = "bold"
    )
    
    writeData(wb, sheet = 1, x = paste0("DOI: ", doi), xy = c(1,2))
    
    addStyle(wb, sheet = 1, doi_style, rows = 2, cols = 1, gridExpand = F)
    
    writeData(wb, sheet = 1, x = final_glossary, xy = c(1, 4), colNames = F, borders = "all", borderStyle = "thin")
    
    glossary_style <- createStyle(wrapText = TRUE)
    
    addStyle(wb, sheet = 1, glossary_style, rows = 4:(4+nrow(final_glossary)), cols = 1:6, gridExpand = T, stack = T)
    
    for(table in unique(protocol_tables)){
      
      protocol_schema <- schema %>%
        filter(protocol_name == protocol,
               sheet_name == table)
      
      addWorksheet(wb, sheetName = table)
      
      num_col <- length(protocol_schema$field_name)
      
      df <- setNames(data.frame(matrix(ncol = num_col, nrow = 0)), protocol_schema$field_name)
      
      if("data_collection_year" %in% colnames(df)){
        df <- df %>%
          select(data_collection_year, data_collection_month, data_collection_day, everything())
      }
      
      col_style <- createStyle(
        fontName = "Calibri",
        fontSize = 11,
        fontColour = "black",
        textDecoration = "bold",
        #numFmt = "GENERAL",
        border = "bottom",
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
                headerStyle = col_style)
      
      setColWidths(wb, sheet = table, cols = 1:num_col, widths = "auto")
      
    }
    
    filename = paste0("./", protocol_filename, "/final_spreadsheets/", 
                      tolower(gsub(" ", "_", protocol)), 
                      "_data_entry_spreadsheet_marinegeo.xlsx")
    
    saveWorkbook(wb, file = filename, overwrite = T)
    
  }
  
  # Save schema to CSV of all schemas for use in data submission portal
  marinegeo_schemas <- read_csv("./resources/marinegeo_schemas.csv")
  
  if(!doi %in% marinegeo_schemas$version){
    
    column_metadata <- c("definition", "field_type", "format_text", "unit", "variable_type")
    
    definitions <- final_glossary_full_cols %>%
      select(field_name, all_of(column_metadata)) 
    
    schema_modified <- schema %>%
      select(-all_of(column_metadata)) %>%
      left_join(definitions, by="field_name") %>%
      mutate(version = doi) %>%
      select(protocol_name, sheet_name, field_name, definition, variable_type, field_type, format_text, unit, version) %>%
      bind_rows(marinegeo_schemas) 
    
    write_csv(schema_modified, "./resources/marinegeo_schemas.csv")
  }
}
