#' Is the path a git repo?
#' @return If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom secretary typewrite_error
#' @export

is_git_repo <-
        function(path_to_local_repo) {
                .Deprecated("isRepo")

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
