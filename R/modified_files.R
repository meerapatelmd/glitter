#' Get a list of modified files in a repo
#' @param path_to_local_repo path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @export

modified_files <-
        function(path_to_local_repo) {
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
                        return(fns)
                } else {
                        secretary::typewrite_italic("No modified files in this repo.\n")
                }
        }

