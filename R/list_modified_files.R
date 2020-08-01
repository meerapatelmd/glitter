#' Get a list of modified files in a repo
#' @description This function takes the git status message and isolates the files that have been modified according to that message.
#' @return The complete git status message and modified files are printed in the console, and a vector of the modified filenames is invisibly returned.
#' @param path_to_local_repo path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

list_modified_files <-
        function(path_to_local_repo) {
                .Deprecated(new = "lsStagedFiles")
                secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)

                status_msg <- status(path_to_local_repo = path_to_local_repo)
                modified_status <- grep("^\tmodified:", status_msg, value = TRUE)

                fns <- vector()
                while (length(modified_status) > 0) {
                        modified_file <- modified_status[1]
                        fn <- stringr::str_replace_all(modified_file,
                                                       pattern = "(^\tmodified:[ ]*)([^ ]{1}.*$)",
                                                       "\\2")

                        fns <- c(fns, fn)
                        modified_status <- modified_status[-1]
                }

                if (length(fns) > 0) {
                        secretary::typewrite_bold("\nModified Files:", line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(fns)
                        invisible(fns)
                } else {
                        invisible(NULL)
                        secretary::typewrite_italic("No modified files in this repo.\n")
                }
        }

