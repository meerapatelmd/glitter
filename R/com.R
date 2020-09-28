#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param commit_msg PARAM_DESCRIPTION
#' @param path_to_local_repo PARAM_DESCRIPTION, Default: NULL
#' @param verbose PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[secretary]{typewrite_bold}},\code{\link[secretary]{character(0)}},\code{\link[secretary]{typewrite_italic}}
#' @rdname com
#' @export
#' @importFrom secretary typewrite_bold yellowTxt typewrite_italic redTxt

com <-
        function(commit_msg,
                 path_to_local_repo = NULL,
                 verbose = TRUE) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          paste0("git commit -m '", commit_msg, "'")) %>%
                        paste(collapse = "\n")

                commit_response <-
                        suppressWarnings(
                                system(command = command,
                                       intern = TRUE))

                if (verbose) {
                        cat("\n")
                        secretary::typewrite_bold(secretary::yellowTxt("\tCommit Response:"))

                        if ("no changes added to commit" %in% commit_response) {
                                secretary::typewrite_italic(secretary::redTxt("\tNo changes added to the commit."))
                        }

                        cat(paste0("\t\t", commit_response), sep = "\n")

                        cat("\n")
                }

                invisible(commit_response)
        }
