#' Get Git Remote URL
#' @param remote_name Name of the remote. Defaults to "Origin".
#' @return url of the remote as a string
#' @export
remote_url <-
  function(path = getwd(),
           remote_name = "origin") {
    suppressWarnings(
      system(paste0(
        "cd\n",
        "cd ", path, "\n",
        "git remote get-url ", remote_name
      ),
      ignore.stderr = TRUE,
      intern = TRUE
      )
    )
  }
