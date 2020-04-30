## MarineGEO Protocols

This repository contains the tools and workflows for developing and maintaining MarineGEO protocols. Individual protocols are written in Rmarkdown and LaTex, based on the protocol-template.Rmd file. Functions within the program script are applied to render these protocols and upload them to the MarineGEO dropbox. These include the following:

generateProtocols()	renders all the subdirectory protocol-generating Rmarkdowns as PDFs

saveProtocols()		uploads the generated protocol PDFs to their respective dropbox folders

**Base Requirements:**
- R and R studio (*packages:* rmarkdown, tidyverse, readxl, lubridate, here, rdrop2)

**Contact:**
For questions or suggestions, please contact Jaxine Wolfe (email: wolfejax@si.edu).