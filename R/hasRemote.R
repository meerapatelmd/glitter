#' Does the GitHub Repo Have a Remote?
#' @return TRUE if the path has a remote url.
#' @param path_to_local_repo full path to local repository to be pushed
#' @export

hasRemote <-
        function(path_to_local_repo = NULL,
                 remote_name = "origin") {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)


                x <- remote_url(path_to_local_repo = path_to_local_repo,
                           remote_name = remote_name)

                if (length(x) == 0) {

                        FALSE

                } else {
                        TRUE
                }
        }
