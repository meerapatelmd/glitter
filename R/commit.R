#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param commit_message message to be included in the commit
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


commit <-
        function(path_to_local_repo, commit_message, description = NULL) {
                if (is.null(description)) {
                        if (dir.exists(path_to_local_repo)) {
                                x <-
                                system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git commit -m '", commit_message, "'"
                                ), intern = TRUE
                                )

                                return(x)

                        } else {
                                typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                        }
                } else {
                        if (dir.exists(path_to_local_repo)) {
                                x <-
                                system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git commit -m '", commit_message, "' ", "-m '", description, "'"
                                ), intern = TRUE
                                )

                                return(x)

                        } else {
                                typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                        }
                }
        }
