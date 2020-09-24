#' Push a local repo to a GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @export


push <-
        function(remote_name = "origin",
                 remote_branch = "master",
                 path_to_local_repo = NULL,
                 verbose = TRUE) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)


                status_response <- status(path_to_local_repo = path_to_local_repo,
                                          verbose = FALSE)

                if (any(grepl('use "git push" to publish your local commits', status_response))) {

                        command <-
                                c(starting_command(path_to_local_repo = path_to_local_repo),
                                  paste0("git push ", remote_name, " ", remote_branch)) %>%
                                paste(collapse = "\n")

                        push_response <-
                                capture.output(
                                system(command = command,
                                       intern = TRUE),
                                type = "message")

                        if (verbose) {
                                cat("\n")
                                secretary::typewrite_bold(secretary::silverTxt("\tPush Response:"))
                                cat(paste0("\t\t", push_response), sep = "\n")
                                cat("\n")
                        }

                        invisible(push_response)

                }

        }
