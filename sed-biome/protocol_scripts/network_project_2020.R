#library(openxlsx)
library(tidyverse)
library(readxl)
##

site_info <- read_xlsx("./sed-biome/data_entry_spreadsheets/Site_info.xlsx")

# Round 1: 1:14, 18
# Round 2: 15:17, 20:29

files_to_create <- site_info %>%
  filter(!is.na(contact_person),
         site_number %in% c(19, 30:49))

for(site in files_to_create$site_number){
  
  country <- filter(files_to_create, site_number == site) %>%
    pull(country)
  
  destination_filename <- paste0("./sed-biome/data_entry_spreadsheets/output_spreadsheets/SED-BIOME_site-",
                                 site, "_", country, ".xlsx")
  
  file.copy(from = "./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx",
            to = destination_filename)
  
}

# file.copy(from = "./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx",
#           to = "./sed-biome/data_entry_spreadsheets/output_spreadsheets/SED-BIOME_site-1.xlsx")

# Issues: Can't preserve data validation
# Can't preserve formulas on sed sheet


# tea_bag_df <- read_xlsx("./sed-biome/data_entry_spreadsheets/Tea_bags_info.xlsx", sheet = "Site 1") %>%
#   mutate_all(as.character)
# 
# colnames(tea_bag_df) <- tolower(colnames(tea_bag_df))
# 
# sed_df <- read_xlsx("./sed-biome/data_entry_spreadsheets/Sedimentation_Info.xlsx") %>%
#   filter(site_number == 1) %>%
#   mutate_all(as.character) 
# 
# wb <- loadWorkbook(file = "./sed-biome/data_entry_spreadsheets/SED-BIOME_data-entry-spreadsheet.xlsx")
# #getStyles(wb)
# 
# df1 <- readWorkbook(wb, sheet="teabag_decomposition_data")
# 
# df1 <- df1 %>%
#   mutate_all(as.character) %>%
#   bind_rows(tea_bag_df)
# 
# df2 <- readWorkbook(wb, sheet="sedimentation_data")
# 
# df2 <- df2 %>%
#   mutate_all(as.character) %>%
#   bind_rows(sed_df)
# 
# writeDataTable(wb, "teabag_decomposition_data", df1, 
#                stack = F, tableStyle = "none", withFilter = F)
# 
# 
# saveWorkbook(wb, file = "./sed-biome/data_entry_spreadsheets/output_spreadsheets/site1.xlsx", overwrite = T)
# 
# 
# ## Trial ####
# wb <- loadWorkbook(file = "./Repositories/marinegeo-data-entry-spreadsheets/templates/network_project_decomp_template.xlsx")
# getStyles(wb)[1:3]
# 
# site <- 1
# location <- "location_at_site_1"
# 
# 
# df1 <- readWorkbook(wb, sheet="sample_metadata")
# df2 <- readWorkbook(wb, sheet="sample_data")
# 
# df1 <- df1 %>%
#   mutate(site_id = site,
#          location_name = location)
# 
# df2 <- df2 %>%
#   mutate(site_id = site,
#          location_name = location)
# 
# writeDataTable(wb, "sample_metadata", df1, stack = TRUE)
# 
# saveWorkbook(wb, file = "./")
