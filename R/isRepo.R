#' Is the path a git repo?
#' @return TRUE if the path has an initialized .git.
#' @param path_to_local_repo full path to local repository to be pushed
#' @export

isRepo <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)

                x <- system(paste0("cd\n",
                       "cd ", path_to_local_repo,"\n",
                       "git status"),
                       intern = TRUE
                )

                if (length(x) == 0) {

                        FALSE

                } else {
                        TRUE
                }
        }
