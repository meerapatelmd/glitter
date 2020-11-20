#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param commit_msg PARAM_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: NULL
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
                 path = getwd(),
                 verbose = TRUE) {


                command <-
                        c(starting_command(path = path),
                          paste0("git commit -m '", commit_msg, "'")) %>%
                        paste(collapse = "\n")

                commit_response <-
                        suppressWarnings(
                                system(command = command,
                                       intern = TRUE))

                if (verbose) {

                        cli::cat_line()
                        cli::cat_rule(secretary::yellowTxt("Commit Response"))

                        if ("no changes added to commit" %in% commit_response) {
                                secretary::typewrite_italic(secretary::redTxt("\tNo changes added to the commit."))
                        }

                        cat(paste0("\t\t", commit_response), sep = "\n")

                        cli::cat_line()
                }

                invisible(commit_response)
        }
