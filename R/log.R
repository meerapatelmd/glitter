#' Git Log
#' @export
log <-
  function(path = getwd(),
           verbose = TRUE) {
    logResponse <-
      system(
        paste0("cd\ncd ", repo_path, "\n", "git log"),
        intern = TRUE
      )

    if (verbose) {
      printMsg(logResponse)
    }

    invisible(logResponse)
  }
