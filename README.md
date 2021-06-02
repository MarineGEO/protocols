## MarineGEO Protocols

This repository contains the tools and workflows for developing and maintaining MarineGEO protocols. 

**Current Projects:**

- Coral Reefs https://doi.org/10.25573/serc.14714175
	- Coral Demographics
	- Rugosity
- Fouling Community https://doi.org/10.25573/serc.14510649
	- Fouling Community Surveys
	- Photo Analysis
	- Mobile Fauna
- Sampling Event and Environmental Monitoring https://doi.org/10.25573/serc.14555511
- SED-BIOME (2020-2021 Network Research Project) 
    - Tea bag decomposition
    - Sediment trap
    - Sediment sampling for metagenomics
- Oyster Surveys https://doi.org/10.25573/serc.14714328
	- Reef area and height
	- Reef associated fauna
	- Reef composition
	- Reef density and size frequency
	- Reef rugosity
	- Reef survey design
- Seagrass Habitats
	- Seagrass biomass
	- Seagrass density
	- Seagrass epifauna
	- Seagrass macroalgae
	- Seagrass shoots
- Diver Visual Survey https://doi.org/10.25573/serc.14717796 
- Fish Trawls
- Beach Seines 
- Environment
	- Sediment organic matter
- Predation Assay https://doi.org/10.25573/serc.14717802
- Ulva Assay https://doi.org/10.25573/serc.14717808
- Benthic Photoquadrats https://doi.org/10.25573/serc.14717823

### How to Develop a MarineGEO Protocol

If you are developing a MarineGEO protocol, please follow the instructions below to ensure that every protocol is standardized in layout. Appropriate branding and citations will be included on the protocols and spreadsheets to properly acknowledge your team’s role in authoring these documents.

*Protocol document layout:*
- Title page: This includes the title of the protocol, a title picture, a citation for the protocol, and the logos of MarineGEO and the partner who assisted in the protocol development. 
- Introduction: Provide some background for the protocol, and a short description of its purpose, and link to any instructional videos or materials.
- Measured Parameters: Indicate what parameters are being quantified by following this protocol.
- Requirements: Breaking down the protocol into preparation, fieldwork, post-processing, and data entry, please indicate estimates for the number of people, the amount of time, and the materials needed to complete each step. For the materials that are not provided, please include links to key items for purchase from preferred providers (ex. temperature loggers).
- Methods: Describe the steps for the preparation, fieldwork, and post-processing. Be sure to reference all the materials used. Please include any helpful graphics, especially ones that are relevant to experimental setup and surveying strategies. 
- Data submission: We have a blurb for this

*Data entry spreadsheets:*

Our spreadsheets are Excel files that are divided into multiple sheets representing protocol metadata, sample metadata, sample data, and a glossary. Each row should represent one observation, consistent with what is known as long-form data. 

*Field spreadsheets:*

Based on these spreadsheets, MarineGEO will develop field datasheets that can be printed and filled out in the field prior to data entry. 

### Protocol-Generating Workflow

Based on the resources/protocol-template.Rmd, individual protocols are written in Rmarkdown to ensure that protocols adhere to a formatting standard. Functions within the program script are applied to render these protocols and upload them to the MarineGEO dropbox. These include the following:

generateProtocols()	renders all the subdirectory protocol-generating Rmarkdowns as PDFs

saveProtocols()		uploads the generated protocol PDFs to their respective dropbox folders

**Base Requirements:**
- R and R studio (*packages:* rmarkdown, tidyverse, readxl, lubridate, here, rdrop2)

**Contact:**
For questions or suggestions, please contact Jaxine Wolfe (email: wolfejax@si.edu).
