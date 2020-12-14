#' @export

list_big_files <-
        function(mb_threshold = 50, path = getwd()) {

                cave::get_mb_size(list.files(path = path,
                                            full.names = TRUE,
                                            recursive = TRUE)) %>%
                        dplyr::filter(mb >= 50) %>%
                        dplyr::select(file) %>%
                        unlist() %>%
                        unique()

        }

#' Get a list of modified files in a repo
#' @description This function takes the git status message and isolates the files that have been modified according to that message.
#' @return The complete git status message and modified files are printed in the console, and a vector of the modified filenames is invisibly returned.
#' @param path path to local repo
#' @importFrom stringr str_replace_all
#' @export

list_modified_files <-
        function(path = getwd()) {
                status_response <- status(path = path,
                                          verbose = FALSE)
                parsed <- parse_status_response(status_response)
                parsed <- unlist(parsed[!(names(parsed) %in% "Branch")])
                parsed <- trimws(parsed)
                parsed <- unname(parsed)

                files <-
                grep(pattern = "modified:",
                     x = parsed,
                     value = TRUE)
                files <- stringr::str_replace_all(string = files,
                                                  pattern = "(modified:)[ ]{1,}([^ ]{1,}.*$)",
                                                  replacement = "\\2")
                files
        }




#' Get a list of deleted files in a repo
#' @importFrom stringr str_replace_all
#' @export

list_deleted_files <-
        function(path = getwd()) {
                status_response <- status(path = path,
                                          verbose = FALSE)
                parsed <- parse_status_response(status_response)
                parsed <- unlist(parsed[!(names(parsed) %in% "Branch")])
                parsed <- trimws(parsed)
                parsed <- unname(parsed)

                files <-
                        grep(pattern = "deleted:",
                             x = parsed,
                             value = TRUE)
                files <- stringr::str_replace_all(string = files,
                                                  pattern = "(deleted:)[ ]{1,}([^ ]{1,}.*$)",
                                                  replacement = "\\2")
                files
        }







#' Get a list of untracked files in a repo
#' @description
#' This function takes the git status message and isolates the files that are new/untracked according to that message.
#' @param path path to local repo
#' @importFrom stringr str_remove_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

list_untracked_files <-
        function(path = getwd(), verbose = TRUE) {

                status_response <- status(path = path,
                                          verbose = FALSE)
                parsed <- parse_status_response(status_response = status_response)
                output <- parsed[names(parsed) %in% "Untracked"]

                if (length(output) > 0) {
                        output <- unlist(output)
                        output <- unname(output)
                        trimws(output)
                } else {
                        cat(secretary::italicize("No untracked files found."))
                }
        }




#' Get a list of unstaged files in a repo
#' @export

list_unstaged_files <-
        function(path = getwd(), verbose = TRUE) {

                status_response <- status(path = path,
                                          verbose = FALSE)
                parsed <- parse_status_response(status_response = status_response)
                output <- parsed[names(parsed) %in% "Unstaged"]

                if (length(output) > 0) {
                        output <- unlist(output)
                        output <- unname(output)
                        output <-
                        stringr::str_replace_all(string = output,
                                                 pattern = "(^.*[:]{1}[ ]{1,})([^ ]{1}.*$)",
                                                 replacement = "\\2")
                        trimws(output)
                } else {
                        cat(secretary::italicize("No unstaged files found."))
                }
        }

#' Get a list of Staged files in a repo
#' @export

list_staged_files <-
        function(path = getwd(), verbose = TRUE) {

                status_response <- status(path = path,
                                          verbose = FALSE)
                parsed <- parse_status_response(status_response = status_response)
                output <- parsed[names(parsed) %in% "Staged"]

                if (length(output) > 0) {
                        output <- unlist(output)
                        output <- unname(output)
                        output <-
                                stringr::str_replace_all(string = output,
                                                         pattern = "(^.*[:]{1}[ ]{1,})([^ ]{1}.*$)",
                                                         replacement = "\\2")
                        trimws(output)
                } else {
                        cat(secretary::italicize("No staged files found."))
                }
        }
