## MarineGEO: Seagrass Habitats Project
## contact: wolfejax@si.edu

# Program script to execute functions for protocol generation and management

library(tidyverse)
# library(rdrop2)

source("scripts/protocol_functions.R")

## Render Rmarkdown protocols to PDF ####

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
# defaults to render ALL protocols unless a specific ONE is specified 

# UNCOMMENT TO RUN
# generateProtocols(protocol = "seagrass", survey_type = NULL)
# generateProtocols(protocol = "shared", survey_type = NULL)
# generateProtocols(protocol = "oyster", survey_type = NULL)
# generateProtocols(protocol = "network-project", survey_type = "network_project")
generateProtocols(protocol = "fouling", survey_type = "community")
generateProtocols(protocol = "fouling", survey_type = "photo")
generateProtocols(protocol = "fouling", survey_type = "mobile")
generateProtocols(protocol = "fouling", survey_type = "design")


