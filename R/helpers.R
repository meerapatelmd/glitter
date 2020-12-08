#' @keywords internal
#' @export

mk_local_path_if_null <-
        function(path_to_local_repo) {

                if (is.null(path_to_local_repo)) {
                        assign("path_to_local_repo", getwd(), envir = parent.frame())
                }
        }

#' @keywords internal
#' @export

extend_path <-
        function(...) {

                normalizePath(path = file.path(...), mustWork = TRUE)
        }

#' @keywords internal
#' @export

starting_command <-
        function(path) {

                sprintf("cd\n
                        cd %s\n",
                        path = path)

        }
