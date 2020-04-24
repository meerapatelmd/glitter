#' Get a list of both untracked and modified files in the wd only
#' @export

wd_files_to_commit <-
        function() {
                filenames <- c(modified_files(path_to_local_repo = getwd()),
                               untracked_files(path_to_local_repo = getwd()))
                filenames <- grep("^[.]{1,}", filenames, invert = TRUE, value = TRUE)
                return(filenames)
        }
