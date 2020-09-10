## marinegeo: Seagrass Habitats Project
## contact: wolfejax@si.edu

# Functions for protocol generation and management

# generateProtocols() renders all the subdirectory protocol-generating Rmarkdowns as PDFs
generateProtocols <- function(protocol, survey_type = NULL){
  
  switch(protocol,
         "seagrass" = {directory = "./seagrass/protocol_scripts"},
         "oyster" = {directory = "./oyster/protocol_scripts"},
         "biodiversity" = {directory = "./biodiversity/protocol_scripts"},
         "environment" = {directory = "./environment/protocol_scripts"},
         "food-webs" = {directory = "./food-webs/protocol_scripts"},
         "fouling" = {directory = "./fouling/protocol_scripts"},
         "network-project" = {directory = "./network-project/protocol_scripts"}
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
# generateProtocols(protocol = "oyster", survey_type = "reef_area")
# generateProtocols(protocol = "oyster", survey_type = "reef_composition")
# generateProtocols(protocol = "oyster", survey_type = "reef_density")
# generateProtocols(protocol = "oyster", survey_type = "associated_fauna")
# generateProtocols(protocol = "oyster", survey_type = "rugosity")
# generateProtocols(protocol = "oyster", survey_type = "shortform")
# generateProtocols(protocol = "oyster", survey_type = "longform")




