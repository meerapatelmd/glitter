#' Perform a Git Commit
#' @param path_to_local_repo full path to local repository to be pushed
#' @param commit_message message to be included in the commit
#' @rdname commit
#' @export

commit <-
        function(commit_message,
                 description = NULL,
                 verbose = TRUE,
                 path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                stagedFiles <- lsStagedFiles(path_to_local_repo = path_to_local_repo)

                if (length(stagedFiles) > 0) {


                                x <-
                                        suppressWarnings(
                                        system(paste0("cd\n",
                                                      "cd ", path_to_local_repo,"\n",
                                                      "git commit -m '", commit_message, "'"
                                        ), intern = TRUE
                                        ))


                                if (verbose) {

                                        printMsg(x)

                                }

                                invisible(x)
                }

        }
