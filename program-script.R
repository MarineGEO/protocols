## Author: Jaxine Wolfe
# This program script contains functions which generate and manage protocol output
# executes all the subdirectory protocol-generating markdowns

# extract file paths to all the protocol-generating .Rmd files within the Modules dir

library(tidyverse)

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

# generateProtocols("format")


saveProtocols <- function(){
  # compile protocol filenames
  git_protocols <- list.files("protocols-final")
  
  # select protocols to ignore
  ignore <- c("format-testing.pdf", "protocol-template.pdf")
  git_protocols <- git_protocols[git_protocols != ignore]

  # upload protocol pdfs to dropbox
  for (f in 1:length(git_protocols)) {
    
    # designate destination of protocol within Dropbox
    # destination <- drop_dir(path = "/MarineGEO/Research/Modules", recursive = TRUE) %>%
    #   filter(name == "Protocol") %>%
    #   select(name, path_display)
    
    drop_upload(paste0("protocols-final/", git_protocols[f]), 
                path = "MarineGEO/Research/Modules/R-generated-protocols/")
  }
}

# saveProtocols()