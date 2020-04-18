#' Add and commit all chnages in repo belonging to the current working directory
#' @param commit_message commit message
#' @param description description, if desired. Defaults to NULL.
#' @export


add_commit_all_this_repo <-
        function(commit_message,
                 description = NULL) {

                return_msg_01 <- add_all_this_repo()
                return_msg_02 <- commit_this_repo(commit_message = commit_message,
                                     description = description)

                return(return_msg_02)
        }

