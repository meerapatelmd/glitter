#' Get a list of both untracked and modified files in the wd only
#' @description This function gets all the modified and untracked files from the path set by getwd() and excludes any of the files in a different path (ie "../other_wd")
#' @export

wd_files_to_commit <-
        function() {
                filenames <- c(modified_files(path_to_local_repo = getwd()),
                               untracked_files(path_to_local_repo = getwd()))
                filenames <- grep("^[.]{1,}", filenames, invert = TRUE, value = TRUE)
                return(filenames)
        }
