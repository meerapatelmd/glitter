#' Push a local repo to a GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


push_wd <-
        function(remote_name = "origin", remote_branch = "master") {
                push(path_to_local_repo = getwd(),
                     remote_branch = remote_branch,
                     remote_name = remote_name)
        }
