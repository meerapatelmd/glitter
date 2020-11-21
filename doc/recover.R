## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(glitter)

## ---- eval=TRUE---------------------------------------------------------------

deleted_files <- list_deleted_files(path = "/Users/meerapatel/GitHub/glitter")
head(deleted_files)


## ---- eval=TRUE---------------------------------------------------------------

list_file_commits(file = "R/destroy.R",
                  path = "/Users/meerapatel/GitHub/glitter")


## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "R/destroy.R",
                  path = "/Users/meerapatel/GitHub/glitter")

## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## -----------------------------------------------------------------------------
file.remove("R/destroy.R")
file.exists("R/destroy.R")

## -----------------------------------------------------------------------------
recover_lost_file(file = "R/destroy.R",
                  path = "/Users/meerapatel/GitHub/glitter", 
                  sha = "aa448c7de4ead65905dfb3133ec42ac8a6f332fc")

## -----------------------------------------------------------------------------
file.exists("R/destroy.R")

## ----echo=FALSE,eval=TRUE-----------------------------------------------------
file.remove("R/destroy.R")

