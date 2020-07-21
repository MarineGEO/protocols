## marinegeo: Seagrass Habitats Project
## contact: wolfejax@si.edu

# Functions for protocol generation and management

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
generateProtocols <- function(protocol, survey_type = NULL){
  
  switch(protocol,
         "seagrass" = {directory = "./seagrass/protocol_scripts"},
         "oyster" = {directory = "./oyster/protocol_scripts"},
         "shared" = {directory = "./shared/protocol_scripts"}
  )
  
  # compile paths to protocol-generating markdowns
  protocol_paths <- dir(directory,
                        pattern = "*.Rmd", 
                        recursive = TRUE, 
                        full.names = TRUE)
  # compile protocol script names
  protocol_names <- dir(directory, pattern = "*.Rmd", recursive = TRUE)
  protocol_names <- gsub(".Rmd", "", protocol_names)
  
  # if a protocol is given, render specified protocol
  if(is.null(survey_type)==FALSE){
    path <- protocol_paths[which(grepl(survey_type, protocol_paths))]
    protocol_name <- protocol_names[which(grepl(survey_type, protocol_names))]
    
    rmarkdown::render(input = path,
                      # output_file = paste0("marinegeo-", protocol_name), 
                      output_dir = paste0(protocol, "/final_protocols"))
  }else{
    # else generate all protocols
    for (i in 1:length(protocol_paths)) {
      # execute the script and generate the protocols within their appropriate subdirectories
      rmarkdown::render(input = protocol_paths[i],
                        # output_file = paste0("marinegeo-", protocol_names[i]), 
                        output_dir = paste0(protocol, "/final_protocols"))
    }
  }
  
  # remove any PDFs in the main directory
  do.call(file.remove, list(list.files(directory,
                                       pattern = "*.pdf",
                                       full.names = TRUE)))
  # remove temporary log files
  do.call(file.remove, list(list.files(directory, 
                                       pattern = "*.log", 
                                       full.names = TRUE)))
}

# generateProtocols(protocol = "seagrass", survey_type = "shoots")


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
  # git_protocols <- list.files("final_protocols")
  # # select protocols to ignore
  # ignore <- c("format-testing.pdf", "protocol-template.pdf")
  # git_protocols <- git_protocols[git_protocols != ignore]
  
  # manually create lookup table to specify output dir for each protocol
  # unfortunately they do not align alphabetically
  lookup <- data.frame(dropbox_path = sort(destination$path_display),
                       git_protocol = c("marinegeo_protocol_beach_seines.pdf",
                                        "marinegeo_protocol_fish_trawls.pdf",
                                        "marinegeo_protocol_visual_census.pdf",
                                        "marinegeo_protocol_herbivory.pdf",
                                        "marinegeo_protocol_predation.pdf",
                                        "marinegeo_protocol_seagrass_biomass.pdf",
                                        "marinegeo_protocol_seagrass_density.pdf",
                                        "marinegeo_protocol_seagrass_epifauna.pdf",
                                        "marinegeo_protocol_seagrass_macroalgae.pdf",
                                        "marinegeo_protocol_seagrass_shoots.pdf",
                                        "marinegeo_protocol_sediment_organic_matter.pdf",
                                        "marinegeo_protocol_environmental_monitoring.pdf"))

  # upload protocol pdfs to dropbox
  for (k in 1:nrow(lookup)) {
    
    rdrop2::drop_upload(file = here::here("final_protocols", lookup$git_protocol[k]), 
                path = lookup$dropbox_path[k])
  }
}

# saveProtocols()


