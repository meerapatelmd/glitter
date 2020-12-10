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
