#' Stop if the directory does not exist
#' @export

stop_if_dir_not_exist <-
        function(path_to_local_repo) {

                if (!(dir.exists(path_to_local_repo))) {

                        stop(path_to_local_repo, " doesn't exist")

                }

        }
