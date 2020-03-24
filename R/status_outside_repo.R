#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


status_outside_repo <-
        function(path_to_local_repo) {
                if (dir.exists(path_to_local_repo)) {
                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git status"),
                               intern = TRUE
                        )
                        return(x)
                } else {
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
