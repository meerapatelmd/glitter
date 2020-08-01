#' Pull a Remote Repo
#' @param path_to_local_repo full path to directory of the repo to be pulled
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

