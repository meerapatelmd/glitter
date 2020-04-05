#' Get a list of deleted files in a repo
#' @param path_to_local_repo path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom mirCat typewrite
#' @export

deleted_files <-
        function(path_to_local_repo) {
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
                        return(fns)
                } else {
                        mirCat::typewrite("\tNo deleted files in this repo.\n")
                }
        }

