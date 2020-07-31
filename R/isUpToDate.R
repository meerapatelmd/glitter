#' Is The Repository Up-To-Date?
#' @param path_to_local_repo path to local repo
#' @export

isUpToDate <-
        function(path_to_local_repo = NULL) {
                git_msg <- pull(path_to_local_repo = path_to_local_repo,
                                verbose = FALSE)
                if ("Already up to date." %in% git_msg) {
                       TRUE
                } else {
                       FALSE
                }
        }
