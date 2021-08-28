#' @title
#' Pull a Remote Repo
#' @export
#' @importFrom magrittr %>%
pull <-
  function(path = getwd(),
           verbose = TRUE,
           ...) {


      command <-
        c(
          starting_command(path = path),
          "git pull"
        ) %>%
        paste(collapse = "\n")


      if (!missing(...)) {

        command <-
        c(command,
          paste(unlist(rlang2::list2(...)),
                collapse = " ")) %>%
          paste(collapse = "\n")

    }

    pull_response <-
      system(
        command = command,
        intern = TRUE
      )

    if (verbose) {
      cat("\n")
      secretary::typewrite_bold(secretary::magentaTxt("\tPull Response:"))
      cat(paste0("\t\t", pull_response), sep = "\n")
      cat("\n")
    }

    invisible(pull_response)
  }
