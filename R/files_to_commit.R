#' Get a list of both untracked and modified files a local git repo
#' @description This function gets all the modified, untracked, and deleted files in the local repo at path_to_local_repo
#' @export

files_to_commit <-
        function(path_to_local_repo) {
                filenames <- c(modified_files(path_to_local_repo = path_to_local_repo),
                               untracked_files(path_to_local_repo = path_to_local_repo),
                               deleted_files(path_to_local_repo = path_to_local_repo))
                filenames <- grep("^[.]{1,}", filenames, invert = TRUE, value = TRUE)
                if (length(filenames) > 0) {
                        secretary::typewrite_bold("\nModified, Untracked, or Deleted Files:", line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(filenames)
                        invisible(filenames)
                } else {
                        secretary::typewrite_italic(paste0("No modified, untracked, or deleted files in ", getwd()))
                }
        }
