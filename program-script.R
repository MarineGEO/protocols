## This will be the program script which executes all the subdirectory generate-protocol.Rmd

# extract file paths to all the protocol-generating .Rmd files within the Modules dir

generate_protocols <- function(protocol = NULL){

  protocol_paths <- list.files(pattern = "*.Rmd", 
                               recursive = TRUE, 
                               full.names = TRUE)
  
  # if a protocol is given, render specified protocol
  if(is.null(protocol)==FALSE){
    path <- protocol_paths[which(grepl(protocol, protocol_paths))]
    rmarkdown::render(input = path,
                      output_dir = "protocols-final")
  }else{
    #   else generate all protocols
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

# test function
# generate_protocols("water")


