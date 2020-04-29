#' Get all modified files in working dir
#' @export

modified_files_in_wd <-
        function() {
                return(
                        grep("^[.]{2}.*",
                             modified_files(path_to_local_repo = getwd()),
                             invert = TRUE,
                             value = TRUE))
        }
