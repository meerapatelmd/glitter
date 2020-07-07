#' Get a list of deleted files in a repo
#' @description Lists all the deleted files according to the git status message returned by the status function
#' @return The Git Status message and deleted files are printed in the console while the vector of the deleted filenames are invisibly returned.
#' @param path_to_local_repo path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @export

deleted_files0 <-
        function(path_to_local_repo) {
                secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)
                status_msg <- status(path_to_local_repo = path_to_local_repo)
                deleted_status <- grep("^\tdeleted:", status_msg, value = TRUE)

                fns <- vector()
                while (length(deleted_status) > 0) {
                        deleted_file <- deleted_status[1]
                        fn <- stringr::str_replace_all(deleted_file,
                                                       pattern = "(^\tdeleted:[ ]*)([^ ]{1}.*$)",
                                                       "\\2")

                        fns <- c(fns, fn)
                        deleted_status <- deleted_status[-1]
                }

                if (length(fns) > 0) {
                        secretary::typewrite_bold("\nDeleted Files:", line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(fns)
                        invisible(fns)
                } else {
                        secretary::typewrite_italic("No deleted files in this repo.")
                }
        }

