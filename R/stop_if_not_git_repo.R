#' Stop if not repo
#' @export


stop_if_not_git_repo <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                if (!is_git_repo(path_to_local_repo = path_to_local_repo)) {

                        stop(path_to_local_repo, " is not a git repository")

                }

        }
