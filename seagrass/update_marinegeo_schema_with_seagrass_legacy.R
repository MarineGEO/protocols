library(tidyverse)

seagrass_schema <- read_csv("./seagrass/seagrass_database_structure.csv")

main_schema <- read_csv("./resources/marinegeo_schemas.csv")

seagrass_revised <- seagrass_schema %>%
  rename(protocol_name = protocol,
         sheet_name = table,
         field_name = attribute,
         field_type = type) %>%
  mutate(version = "seagrass_legacy") %>%
  filter(status == "active") %>%
  select(-status, -id_variable)

updated_main <- main_schema %>%
  bind_rows(seagrass_revised)

write_csv(updated_main, "./resources/marinegeo_schemas.csv")
