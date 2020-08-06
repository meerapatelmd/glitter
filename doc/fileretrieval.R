## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(glitter)
library(tidyverse)
library(rlang)

## ---- eval=TRUE---------------------------------------------------------------

deletedFileHistory()


## ---- eval=TRUE---------------------------------------------------------------

fileCommitHistory(filePath = "R/logo.R",
                  repo_path = "~/GitHub/Public-Packages/glitter/")


## ---- eval=FALSE--------------------------------------------------------------
#  retrieveLostFile(sha = "1b9ac7e47fc77f12c21ed2447a71ae8d77a0f37c",
#                   filePath = "R/logo.R",
#                   repo_path = "~/GitHub/Public-Packages/glitter")

