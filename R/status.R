#' @title Get the Git status of any local repo using the path
#' @return
#' If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path_to_local_repo full path to local repository to be pushed
#' @export


status <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                        mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                        command <-
                                c(starting_command(path_to_local_repo = path_to_local_repo),
                                  "git status") %>%
                                paste(collapse = "\n")

                        status_response <-
                                system(command = command,
                                       intern = TRUE)

                        if (verbose) {
                                cat("\n")
                                secretary::typewrite_bold(secretary::greenTxt("\tStatus Response:"))
                                cat(paste0("\t\t", status_response), sep = "\n")
                                cat("\n")
                        }

                        invisible(status_response)

        }
