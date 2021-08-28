#' Get Git Remote URL
#' @param remote_name Name of the remote. Defaults to "Origin".
#' @return url of the remote as a string
#' @export
remote_url <-
  function(path = getwd(),
           remote_name = "origin") {


    command <-
      as.character(
        glue::glue(
          "cd",
          "cd {path}",
          "git remote get-url {remote_name}",
          .sep = "\n"
        )
      )




    suppressWarnings(
      system(command = command,
      ignore.stderr = TRUE,
      intern = TRUE
      )
    )
  }
