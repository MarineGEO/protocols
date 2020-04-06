## This will be the program script which executes all the subdirectory generate-protocol.Rmd

# extract file paths to all the protocol-generating .Rmd files within the Modules dir

# generate_protocols <- function(protocol = NULL){
#   if a protocol is given, render specified protocol
#   else generate all protocols
# }

protocol_paths <- list.files(pattern = "*.Rmd", 
                             recursive = TRUE, 
                             full.names = TRUE)

for (i in 1:length(protocol_paths)) {
  # execute the script and generate the protocols within their appropriate subdirectories
  rmarkdown::render(input = protocol_paths[i],
                    # output_file = "something", # only specify to rename the output
                    output_dir = "protocols-final")
}

# remove temporary log files
do.call(file.remove, list(list.files(pattern = "*.log", 
                                     full.names = TRUE)))
