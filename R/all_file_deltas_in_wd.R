#' Get a vector of changed files in the current working directory
#' @export

all_file_deltas_in_wd <-
        function() {
                all_files <- c(modified_files_in_wd(),
                               untracked_files_in_wd(),
                               deleted_files_in_wd())
                return(all_files)
        }
