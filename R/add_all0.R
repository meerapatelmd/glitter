#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_all0 <-
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
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
