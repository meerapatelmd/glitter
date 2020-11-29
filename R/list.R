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
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

list_modified_files <-
        function(path) {
                .Deprecated(new = "lsStagedFiles")
                secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)

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












#' Get a list of untracked files in a repo
#' @description This function takes the git status message and isolates the files that are new/untracked according to that message.
#' @return The complete git status message and untracked files are printed in the console, and a vector of the untracked filenames is invisibly returned.
#' @param path path to local repo
#' @importFrom stringr str_remove_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

list_untracked_files <-
        function(path, verbose = TRUE) {

                .Deprecated(new = "lsUntrackedFiles")

                if (verbose == TRUE) {

                        secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)
                        status_msg <- status(path = path)

                        if ("Untracked files:" %in% status_msg) {

                                ##Creating a draft to string search against
                                status_msg_draft <- status_msg

                                ##Breaking the Untracked Files section into header, filenames, and footer,
                                ##First getting header line numbers
                                start_line <- grep("Untracked files:", status_msg_draft) ##Getting the starting line of the git untracked file message
                                next_blank_line <- start_line + 2 #including the blank line because the next blank line will be the end

                                ##Getting footer line numbers
                                status_msg_draft <-
                                        status_msg_draft[-(1:next_blank_line)]
                                ending_blank_line <- grep("\t", status_msg_draft, invert = TRUE)[1] + next_blank_line

                                ##Getting exclusive lines between the header and footer
                                output <-
                                        status_msg[(next_blank_line+1):
                                                           (ending_blank_line-1)]

                                ##Cleaning up names
                                output <- stringr::str_remove_all(output, "[\t\r\n]")

                                secretary::typewrite_bold("\nUntracked Files:", line_number = 0, add_to_readme = FALSE)
                                pretty_if_exists(output)
                                invisible(output)

                        } else {
                                secretary::typewrite_italic("No untracked files in this repo.\n")
                        }
                } else {
                        status_msg <- status(path = path)

                        if ("Untracked files:" %in% status_msg) {

                                ##Creating a draft to string search against
                                status_msg_draft <- status_msg

                                ##Breaking the Untracked Files section into header, filenames, and footer,
                                ##First getting header line numbers
                                start_line <- grep("Untracked files:", status_msg_draft) ##Getting the starting line of the git untracked file message
                                next_blank_line <- start_line + 2 #including the blank line because the next blank line will be the end

                                ##Getting footer line numbers
                                status_msg_draft <-
                                        status_msg_draft[-(1:next_blank_line)]
                                ending_blank_line <- grep("\t", status_msg_draft, invert = TRUE)[1] + next_blank_line

                                ##Getting exclusive lines between the header and footer
                                output <-
                                        status_msg[(next_blank_line+1):
                                                           (ending_blank_line-1)]

                                ##Cleaning up names
                                output <- stringr::str_remove_all(output, "[\t\r\n]")

                                #secretary::typewrite_bold("\nUntracked Files:", line_number = 0, add_to_readme = FALSE)
                                #pretty_if_exists(output)
                                return(output)

                        }

                }
        }






