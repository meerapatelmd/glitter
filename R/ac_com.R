





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
                        system(command = command,
                               intern = TRUE)

                if (verbose) {
                        secretary::typewrite_bold(secretary::yellowTxt("\tCommit"))
                        cat(paste0("\t\t", commit_response), sep = "\n")
                }

                invisible(commit_response)
        }




ac <-
        function(...,
                 all = FALSE,
                 path_to_local_repo = NULL,
                 max_mb = 50)

                {


                add(...,
                    all = all,
                    path_to_local_repo = path_to_local_repo,
                    max_mb = max_mb)







        }
