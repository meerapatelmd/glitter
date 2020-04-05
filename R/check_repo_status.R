#' Check whether a commit is needed or not for a given repo
#' @param path_to_local_repo
#' @importFrom mirCat typewrite
#' @export

check_repo_status <-
        function(path_to_local_repo) {
                x <- status(path_to_local_repo = path_to_local_repo)
                if ("nothing to commit, working tree clean" %in% x) {
                       mirCat::typewrite("\tnothing to commit, working tree clean\n")
                } else {
                        mirCat::typewrite("\tcommits needed:\n")
                        pretty(x)
                }
        }
