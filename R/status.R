#' @title Get the Git status of any local repo using the path
#' @return
#' If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path full path to local repository to be pushed
#' @export
status <-
  function(path = getwd(),
           verbose = TRUE,
           header = "Status Response") {
    command <- sprintf("cd\ncd %s\ngit status", path)

    status_response <-
      system(
        command = command,
        intern = TRUE
      )

    if (verbose) {
      cli::cat_line()
      cli::cat_rule(secretary::greenTxt(header))
      cat(paste0("\t\t", status_response), sep = "\n")
      cli::cat_line()
    }

    invisible(status_response)
  }
