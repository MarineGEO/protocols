## MarineGEO: Seagrass Habitats Project
# contact: wolfejax@si.edu

# Functions for protocol generation and management

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
# saveProtocols() uploads the generated protocol PDFs to their respective dropbox folders

library(tidyverse)
library(rdrop2)
library(here)

# output_dropbox = TRUE (default false) option? separate function for now...
generateProtocols <- function(protocol = NULL){
  # compile paths to protocol-generating markdowns
  protocol_paths <- list.files(pattern = "*.Rmd", 
                               recursive = TRUE, 
                               full.names = TRUE)
  
  # if a protocol is given, render specified protocol
  if(is.null(protocol)==FALSE){
    path <- protocol_paths[which(grepl(protocol, protocol_paths))]
    rmarkdown::render(input = path,
                      output_dir = "protocols-final")
  }else{
    # else generate all protocols
    for (i in 1:length(protocol_paths)) {
      # execute the script and generate the protocols within their appropriate subdirectories
      rmarkdown::render(input = protocol_paths[i],
                        # output_file = "something", # only specify to rename the output
                        output_dir = "protocols-final")
    }
    }

  # remove temporary log files
  do.call(file.remove, list(list.files(pattern = "*.log", 
                                       full.names = TRUE)))
  
}

# generateProtocols("epifauna")

saveProtocols <- function(){
  
  # designate destination of protocol within Dropbox
  destination <- rdrop2::drop_dir(path = "/MarineGEO/Research/Modules", recursive = TRUE) %>%
    filter(name == "Protocol") %>%
    select(name, path_display) %>%
    # ignore unnecessary protocol folders
    filter(!grepl("coral|Coral|collections", path_display)) %>%
    # eliminate first forward slash (otherwise files won't upload)
    mutate(path_display = sub(".", "", path_display))
  
  # # compile protocol filenames
  # git_protocols <- list.files("protocols-final")
  # # select protocols to ignore
  # ignore <- c("format-testing.pdf", "protocol-template.pdf")
  # git_protocols <- git_protocols[git_protocols != ignore]
  
  # manually create lookup table to specify output dir for each protocol
  # unfortunately they do not align alphabetically
  lookup <- data.frame(dropbox_path = sort(destination$path_display),
                       git_protocol = c("protocol-fish-seines.pdf",
                                        "protocol-fish-trawls.pdf",
                                        "protocol-visual-census.pdf",
                                        "protocol-herbivory.pdf",
                                        "protocol-predation.pdf",
                                        "protocol-seagrass-biomass.pdf",
                                        "protocol-seagrass-density.pdf",
                                        "protocol-seagrass-epifauna.pdf",
                                        "protocol-seagrass-macroalgae.pdf",
                                        "protocol-seagrass-shoots.pdf",
                                        "protocol-sediment-organic-matter.pdf",
                                        "protocol-water-quality.pdf"))

  # upload protocol pdfs to dropbox
  for (k in 1:nrow(lookup)) {
    
    rdrop2::drop_upload(file = here::here("protocols-final", lookup$git_protocol[k]), 
                path = lookup$dropbox_path[k])
  }
}

# saveProtocols()


