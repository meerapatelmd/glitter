#' Check whether a commit is needed or not for a given repo
#' @param path_to_local_repo path to the local repo
#' @importFrom secretary typewrite
#' @export

check_repo_status <-
        function(path_to_local_repo) {
                .Deprecated(new = "isWorkingTreeClean")
                x <- status(path_to_local_repo = path_to_local_repo)
                if ("nothing to commit, working tree clean" %in% x) {
                       secretary::typewrite("\tnothing to commit, working tree clean\n")
                } else {
                        secretary::typewrite("\tcommits needed:\n")
                        pretty(x)
                        invisible(x)
                }
        }
