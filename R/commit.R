#' Push a Local Repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param commit_message message to be included in the commit
#' @export


commit <-
        function(path_to_local_repo = NULL,
                 commit_message,
                 description = NULL,
                 verbose = TRUE) {

                if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                if (is.null(description)) {

                                x <-
                                system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git commit -m '", commit_message, "'"
                                ), intern = TRUE
                                )


                } else {
                                x <-
                                system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git commit -m '", commit_message, "' ", "-m '", description, "'"
                                ), intern = TRUE
                                )
                }


                if ("no changes added to commit." %in% x) {

                        stop("No changes added to commit.")

                }

                if (verbose) {

                        printMsg(x)

                }

                invisible(x)
        }
