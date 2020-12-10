## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup,message=FALSE------------------------------------------------------
library(glitter)

## -----------------------------------------------------------------------------
path <- clone(github_user = "meerapatelmd",
              repo = "glitter",
              destination_path = getwd())

## ---- eval=TRUE---------------------------------------------------------------
list_file_commits(file = "R/destroy.R",
                  path = path)

## ----echo=FALSE,eval=TRUE-----------------------------------------------------
# QA for vignette to run correctly 
path_to_file <- file.path(path, "R/destroy.R")
if (file.exists(path_to_file)) {
    file.remove(path_to_file)
} 

## -----------------------------------------------------------------------------
file.exists(path_to_file)

## -----------------------------------------------------------------------------
recover_lost_file(file = path_to_file)

## -----------------------------------------------------------------------------
file.exists(path_to_file)

## -----------------------------------------------------------------------------
file.remove(path_to_file)

## -----------------------------------------------------------------------------
recover_lost_file(file = path_to_file, 
                  sha = "aa448c7de4ead65905dfb3133ec42ac8a6f332fc")

## -----------------------------------------------------------------------------
file.exists(path_to_file)

## ----echo=FALSE,eval=TRUE,message=FALSE,include=FALSE-------------------------
file.remove(path_to_file)

