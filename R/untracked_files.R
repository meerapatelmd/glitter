#' Get a list of untracked files in a repo
#' @param path_to_local_repo
#' @importFrom stringr str_remove_all
#' @importFrom mirCat typewrite
#' @export

untracked_files <-
        function(path_to_local_repo) {
                status_msg <- status(path_to_local_repo = path_to_local_repo)

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

                        return(output)

                } else {
                        mirCat::typewrite("\tNo untracked files in this repo.\n")
                }
        }

