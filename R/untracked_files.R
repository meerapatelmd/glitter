#' List all unstaged files by File Type
#' @importFrom tibble tibble
#' @importFrom rubix split_deselect
#' @importFrom Hmisc capitalize
#' @import dplyr
#' @import tidyr
#' @keywords internal
#' @export


untracked_files <-
        function(path_to_local_repo = NULL) {
                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                status_msg <- status(path_to_local_repo = path_to_local_repo,
                                     verbose = FALSE)

                start_index <- grep("Untracked files:", status_msg)
                status_msg <- status_msg[start_index:length(status_msg)]

                end_index <- grep("^$", status_msg)[1] #Take the first one because can have multiple sections buffered with a blank line
                status_msg <- status_msg[1:end_index]

                #Removing padding
                remove_lines <- c("Untracked files:",
                                  "  (use \"git add <file>...\" to include in what will be committed)",
                                  "")


                files <- status_msg[!(status_msg %in% remove_lines)]
                files_df <- tibble::tibble(`File Path` = files)
                files_df <-
                        files_df %>%
                        dplyr::mutate_at(vars(`File Path`), function(x) trimws(x))

              return(files_df)

        }

