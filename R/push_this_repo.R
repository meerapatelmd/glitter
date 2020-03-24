#' Push a local repo to a GitHub repository
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @export


push_this_repo <-
        function(remote_name = "origin", remote_branch = "master") {
                        x <- system(paste0("git push ", remote_name, " ", remote_branch), intern = TRUE)
                        return(x)
        }
