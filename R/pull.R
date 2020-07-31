#' Pull a GitHub repo based on the path to local repo
#' @param path_to_local_repo full path to directory of the repo to be pulled. If the path does not exist, it will be cloned to the parent directory.
#' @return pulled or cloned repo at the given path_to_local_repo
#' @importFrom crayon red
#' @importFrom typewriteR tell_me
#' @export

pull <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                        pullMessage <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git pull"
                        ), intern = TRUE
                        )

                if (verbose) {
                        printMsg(pullMessage)
                }

                invisible(pullMessage)

        }

