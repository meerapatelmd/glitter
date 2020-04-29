#' Get all deleted files in the current wd
#' @export

deleted_files_in_wd <-
        function() {
                return(
                        grep("^[.]{2}.*",
                             deleted_files(path_to_local_repo = getwd()),
                             invert = TRUE,
                             value = TRUE))
        }
