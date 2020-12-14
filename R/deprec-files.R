#' (Deprecated) Get a list of modified files in a repo
#' @description (Deprecated) This function takes the git status message and isolates the files that have been modified according to that message.
#' @return The complete git status message and modified files are printed in the console, and a vector of the modified filenames is invisibly returned.
#' @param path path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

modified_files <-
        function(path = getwd()) {

                .Deprecated("list_modified_files")


                #secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)

                status_msg <- status(path = path)
                modified_status <- grep("^\tmodified:", status_msg, value = TRUE)

                fns <- vector()
                while (length(modified_status) > 0) {
                        modified_file <- modified_status[1]
                        fn <- stringr::str_replace_all(modified_file,
                                                       pattern = "(^\tmodified:[ ]*)([^ ]{1}.*$)",
                                                       "\\2")

                        fns <- c(fns, fn)
                        modified_status <- modified_status[-1]
                }

                if (length(fns) > 0) {
                        secretary::typewrite_bold("\nModified Files:", line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(fns)
                        invisible(fns)
                } else {
                        invisible(NULL)
                        secretary::typewrite_italic("No modified files in this repo.\n")
                }
        }






#' (Deprecated) List all unstaged files by File Type
#' @importFrom tibble tibble
#' @importFrom rubix split_deselect
#' @importFrom Hmisc capitalize
#' @import dplyr
#' @import tidyr
#' @keywords internal
#' @export


unstaged_files <-
        function(path = getwd()) {

                .Deprecated("list_unstaged_files")


                status_msg <- status(path = path,
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

                split(files_df, files_df$`File Type`) %>%
                        purrr::map(~ function(x) x %>% dplyr::select(-`File Type`))

        }






#' (Deprecated) List all unstaged files by File Type
#' @importFrom tibble tibble
#' @importFrom rubix split_deselect
#' @importFrom Hmisc capitalize
#' @import dplyr
#' @import tidyr
#' @keywords internal
#' @export


untracked_files <-
        function(path = getwd()) {

                .Deprecated("list_untracked_files")

                status_msg <- status(path = path,
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






