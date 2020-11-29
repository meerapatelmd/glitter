## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup,message=FALSE------------------------------------------------------
library(glitter)

## ---- eval=TRUE---------------------------------------------------------------
list_file_commits(file = "R/destroy.R",
                  path = "/Users/meerapatel/GitHub/packages/glitter")

## ----echo=FALSE,eval=TRUE-----------------------------------------------------
# QA for vignette to run correctly 
path_to_file <- file.path("/Users/meerapatel/GitHub/packages/glitter", "R/destroy.R")
if (file.exists(path_to_file)) {
    file.remove(path_to_file)
} 

## -----------------------------------------------------------------------------
file.exists("/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

## -----------------------------------------------------------------------------
file.exists("/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

## -----------------------------------------------------------------------------
file.remove("/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "/Users/meerapatel/GitHub/packages/glitter/R/destroy.R", 
                  sha = "aa448c7de4ead65905dfb3133ec42ac8a6f332fc")

## -----------------------------------------------------------------------------
file.exists("/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

## ----echo=FALSE,eval=TRUE,message=FALSE---------------------------------------
file.remove("/Users/meerapatel/GitHub/packages/glitter/R/destroy.R")

