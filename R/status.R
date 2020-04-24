#' Get the Git status of any local repo using the path
#' @return If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom secretary typewrite_error
#' @export


status <-
        function(path_to_local_repo) {
                if (dir.exists(path_to_local_repo)) {
                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git status"),
                               intern = TRUE
                        )
                        pretty_if_exists(x)
                        return(x)
                } else {
                        secretary::typewrite_error("Local repository", path_to_local_repo, "does not exist.")
                }
        }
