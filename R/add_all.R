#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom secretary typewrite_error
#' @export


add_all <-
        function(path_to_local_repo) {
                if (dir.exists(path_to_local_repo)) {
                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git add ."),
                               intern = TRUE
                        )
                        return(x)
                } else {
                        secretary::typewrite_error("Local repository", path_to_local_repo, "does not exist.")
                }
        }
