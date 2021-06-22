## Validate sed-biome data entry spreadsheet ####

library(readxl)
library(tidyverse)

template_sheets <- excel_sheets("./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx")

# Remove glossary and protocol metadata
template_sheets <- template_sheets[!template_sheets %in% c("glossary", "protocol_metadata")]

glossary <- read_xlsx("./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx", sheet = "glossary") %>%
  filter(!is.na(field_name))

for(sheet_name in template_sheets){
  column_names <- glossary %>%
    filter(sheet == sheet_name) %>%
    pull(field_name)
  
  df_names <- colnames(read_xlsx("./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx", sheet = sheet_name))
  
  print(sheet_name)
  if(!all(df_names %in% column_names) | !all(column_names %in% df_names)){
    print("Glossary field names")
    print(column_names)
    print("Table field names")
    print(df_names)
  } else {
    print("MATCH")
  }
}

