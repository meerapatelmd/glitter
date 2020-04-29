#' Get all untracked files in the current working dir
#' @export

untracked_files_in_wd <-
        function() {
                return(
                grep("^[.]{2}.*",
                     untracked_files(path_to_local_repo = getwd()),
                     invert = TRUE,
                     value = TRUE))
        }







