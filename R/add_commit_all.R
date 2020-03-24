#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_commit_all <-
        function(path_to_local_repo,
                 commit_message,
                 description = NULL) {

                return_msg_01 <- git_add_all(path_to_local_repo)

                return_msg_02 <- git_commit(path_to_local_repo,
                                        commit_message = commit_message,
                                        description = description)

                return(paste(return_msg_01, return_msg_02, collapse = "\n"))
        }

