#' Get the Git status of any local repo using the path
#' @return If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom secretary typewrite_error
#' @export


status <-
        function(path_to_local_repo = NULL, verbose = TRUE) {

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                        }

                        stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                        stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git status"),
                               intern = TRUE
                        )

                        if (verbose) {

                                printMsg(git_msg = x)

                        }

                        invisible(x)

        }
