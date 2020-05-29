## MarineGEO: Seagrass Habitats Project
## contact: wolfejax@si.edu

# Functions for protocol generation and management

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
generateProtocols <- function(protocol = NULL){
  # compile paths to protocol-generating markdowns
  protocol_paths <- list.files(pattern = "*.Rmd", 
                               recursive = TRUE, 
                               full.names = TRUE)
  
  protocol_names <- list.files(pattern = "*.Rmd", 
                               recursive = TRUE)
  protocol_names <- gsub(".Rmd", "", protocol_names)
  
  # if a protocol is given, render specified protocol
  if(is.null(protocol)==FALSE){
    path <- protocol_paths[which(grepl(protocol, protocol_paths))]
    protocol_name <- protocol_names[which(grepl(protocol, protocol_names))]
    
    rmarkdown::render(input = path,
                      output_file = paste0("MarineGEO-", protocol_name), 
                      output_dir = "protocols-final")
  }else{
    # else generate all protocols
    for (i in 1:length(protocol_paths)) {
      # execute the script and generate the protocols within their appropriate subdirectories
      rmarkdown::render(input = protocol_paths[i],
                        output_file = paste0("MarineGEO-", protocol_names[i]), 
                        output_dir = "protocols-final")
    }
    }

  # remove temporary log files
  do.call(file.remove, list(list.files(pattern = "*.log", 
                                       full.names = TRUE)))
  # remove any PDFs in the main directory
  do.call(file.remove, list(list.files(pattern = "*.pdf", 
                                       full.names = TRUE)))
}

# generateProtocols("epifauna")


# saveProtocols() uploads the generated protocol PDFs to their respective dropbox folders
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
                       git_protocol = c("MarineGEO-protocol-fish-seines.pdf",
                                        "MarineGEO-protocol-fish-trawls.pdf",
                                        "MarineGEO-protocol-visual-census.pdf",
                                        "MarineGEO-protocol-herbivory.pdf",
                                        "MarineGEO-protocol-predation.pdf",
                                        "MarineGEO-protocol-seagrass-biomass.pdf",
                                        "MarineGEO-protocol-seagrass-density.pdf",
                                        "MarineGEO-protocol-seagrass-epifauna.pdf",
                                        "MarineGEO-protocol-seagrass-macroalgae.pdf",
                                        "MarineGEO-protocol-seagrass-shoots.pdf",
                                        "MarineGEO-protocol-sediment-organic-matter.pdf",
                                        "MarineGEO-protocol-water-quality.pdf"))

  # upload protocol pdfs to dropbox
  for (k in 1:nrow(lookup)) {
    
    rdrop2::drop_upload(file = here::here("protocols-final", lookup$git_protocol[k]), 
                path = lookup$dropbox_path[k])
  }
}

# saveProtocols()


