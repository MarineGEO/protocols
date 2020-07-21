## MarineGEO: Seagrass Habitats Project
## contact: wolfejax@si.edu

# Program script to execute functions for protocol generation and management

library(tidyverse)
library(rdrop2)

source("protocol_functions.R")

## Render Rmarkdown protocols to PDF ####

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
# defaults to render ALL protocols unless a specific ONE is specified 

# # Uncomment to run
# generateProtocols(protocol = "seagrass", survey_type = NULL)
# generateProtocols(protocol = "shared", survey_type = NULL)
# generateProtocols(protocol = "oyster", survey_type = NULL)

## Save Protocol PDFs to Dropbox ####

# saveProtocols() uploads the generated protocol PDFs to their respective dropbox folders

# DO NOT RUN: FUNCTION BEING UPDATED
# saveProtocols()


