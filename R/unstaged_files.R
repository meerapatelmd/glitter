#' List all unstaged files by File Type
#' @importFrom tibble tibble
#' @importFrom rubix split_deselect
#' @importFrom Hmisc capitalize
#' @import dplyr
#' @import tidyr
#' @export


unstaged_files <-
        function(path_to_local_repo = NULL) {

                .Deprecated("lsUnstagedFiles")

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                status_msg <- status(path_to_local_repo = path_to_local_repo,
                                     verbose = FALSE)

                start_index <- grep("Changes not staged for commit:", status_msg)
                status_msg <- status_msg[start_index:length(status_msg)]

                end_index <- grep("^$", status_msg)[1] #Take the first one because can have multiple sections buffered with a blank line
                status_msg <- status_msg[1:end_index]

                #Removing padding
                remove_lines <- c("Changes not staged for commit:",
                                  "  (use \"git add <file>...\" to update what will be committed)",
                                  "  (use \"git restore <file>...\" to discard changes in working directory)",
                                  "")


                files <- status_msg[!(status_msg %in% remove_lines)]


                files_df <- tibble::tibble(files)
                files_df <-
                        files_df %>%
                        tidyr::extract(col = files,
                                       into = c("File Type", "File Path"),
                                       regex = "(^.*?[:]{1}[ ]{1,})([^ ]{1}.*$)")

                files_df <-
                        files_df %>%
                        dplyr::mutate_all(trimws) %>%
                        dplyr::mutate_at(vars(`File Type`),
                                         function(x) stringr::str_remove_all(x, "[:]{1}$")) %>%
                        dplyr::mutate_at(vars(`File Type`),
                                         function(x) Hmisc::capitalize(x))

                rubix::split_deselect(files_df,
                                      "File Type")

        }

