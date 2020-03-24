#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_commit_some <-
        function(path_to_local_repo, filenames, commit_message, description = NULL) {
                if (dir.exists(path_to_local_repo)) {
                        return_msg_01 <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n"),
                               intern = TRUE
                               )

                        return_msg_02 <- list()
                        for (i in 1:length(filenames)) {
                                return_msg_02[i] <- system(paste0("git add ", filenames[i]), intern = TRUE)
                        }
                        return(paste(return_msg_01, return_msg_02, collapse = "\n"))
                } else {
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
