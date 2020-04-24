#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_commit_all <-
        function(path_to_local_repo,
                 commit_message = NULL,
                 description = NULL) {

                filenames <- files_to_commit(path_to_local_repo = path_to_local_repo)

                git_message <- add_commit_some(path_to_local_repo = path_to_local_repo,
                                filenames = filenames,
                                commit_message = commit_message,
                                description = description)

                pretty_if_exists(git_message)
                invisible(git_message)

                # return_msg_01 <- add_all(path_to_local_repo)
                #
                # return_msg_02 <- commit(path_to_local_repo,
                #                         commit_message = commit_message,
                #                         description = description)
                #
                # return(return_msg_02)
        }

