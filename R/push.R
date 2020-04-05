#' Push a local repo to a GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


push <-
        function(path_to_local_repo, remote_name = "origin", remote_branch = "master") {
                if (dir.exists(path_to_local_repo)) {
                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git push ", remote_name, " ", remote_branch),
                               intern = TRUE
                        )
                        pretty_if_exists(x)
                } else {
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
