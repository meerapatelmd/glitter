## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  cache = TRUE
)

## ----setup,message=FALSE------------------------------------------------------
library(glitter)
setwd("/Users/meerapatel/GitHub/packages/glitter")

## ---- eval=TRUE---------------------------------------------------------------

list_file_commits(file = "R/destroy.R")


## ----echo=FALSE,eval=TRUE-----------------------------------------------------
# QA for vignette to run correctly 
if (file.exists("R/destroy.R")) {
    file.remove("R/destroy.R")
} 

## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "R/destroy.R")

## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## -----------------------------------------------------------------------------
file.remove("R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "R/destroy.R", 
                  sha = "aa448c7de4ead65905dfb3133ec42ac8a6f332fc")

## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## ----echo=FALSE,eval=TRUE-----------------------------------------------------
file.remove("R/destroy.R")

