#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path_to_local_repo PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[secretary]{typewrite_warning}}
#' @rdname root
#' @export
#' @importFrom secretary typewrite_warning


root <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                command <-
                        c("cd",
                          paste0("cd ", path_to_local_repo),
                          "git rev-parse --show-toplevel") %>%
                        paste(collapse = "\n")

                output <-
                        system(command = command,
                               intern = FALSE,
                               ignore.stdout = TRUE,
                               ignore.stderr = TRUE)

                if (output == 0) {

                        system(command = command,
                               intern = TRUE)

                } else {

                        secretary::typewrite_warning("No git root dir found.")
                        invisible(NULL)
                }

        }
