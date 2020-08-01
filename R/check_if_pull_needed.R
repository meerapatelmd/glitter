#' Check if pull for a given repo is needed
#' @param path_to_local_repo path to local repo
#' @keywords internal
#' @export

check_if_pull_needed <-
        function(path_to_local_repo) {
                .Deprecated()
                git_msg <- pull(path_to_local_repo = path_to_local_repo)
                if (git_msg[1] == "Already up to date.") {
                        return(FALSE)
                } else {
                        return(TRUE)
                }
        }
