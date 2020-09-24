#' Pull a Remote Repo
#' @param path_to_local_repo full path to directory of the repo to be pulled
#' @export

pull <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          "git pull") %>%
                        paste(collapse = "\n")

                pull_response <-
                        system(command = command,
                               intern = TRUE)

                if (verbose) {
                        cat("\n")
                        secretary::typewrite_bold(secretary::magentaTxt("\tPull Response:"))
                        cat(paste0("\t\t", pull_response), sep = "\n")
                        cat("\n")
                }

                invisible(pull_response)

        }

