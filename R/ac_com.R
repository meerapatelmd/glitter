





com <-
        function(commit_msg,
                 path_to_local_repo = NULL,
                 verbose = TRUE) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          paste0("git commit -m '", commit_msg, "'")) %>%
                        paste(collapse = "\n")

                commit_response <-
                        suppressWarnings(
                        system(command = command,
                               intern = TRUE))

                if (verbose) {
                        cat("\n")
                        secretary::typewrite_bold(secretary::yellowTxt("\tCommit Response:"))

                        if ("no changes added to commit" %in% commit_response) {
                                secretary::typewrite_italic(secretary::redTxt("\tNo changes added to the commit."))
                        }

                        cat(paste0("\t\t", commit_response), sep = "\n")

                        cat("\n")
                }

                invisible(commit_response)
        }




ac <-
        function(...,
                 all = FALSE,
                 commit_msg,
                 path_to_local_repo = NULL,
                 verbose = TRUE,
                 max_mb = 50)

                {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                add(...,
                    all = all,
                    path_to_local_repo = path_to_local_repo,
                    max_mb = max_mb)


                com(commit_msg = commit_msg,
                    path_to_local_repo = path_to_local_repo,
                    verbose = verbose)


        }
