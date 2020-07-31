#' Check whether a commit is needed or not for a given repo
#' @param path_to_local_repo path to the local repo
#' @importFrom secretary typewrite
#' @export

isWorkingTreeClean <-
        function(path_to_local_repo = NULL) {


                gitMessage <- status(path_to_local_repo = path_to_local_repo,
                            verbose = FALSE)

                if ("nothing to commit, working tree clean" %in% gitMessage) {
                       TRUE
                } else {
                       FALSE
                }
        }
