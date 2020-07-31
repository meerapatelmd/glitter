#' List Files To Commit
#' @description This function combines all the Unstaged and Untracked files in a repo.
#' @export


filesToCommit <-
        function(path_to_local_repo = NULL,
                 label = FALSE) {

                c(lsUnstagedFiles(path_to_local_repo = path_to_local_repo,
                                  label = label),
                  lsUntrackedFiles(path_to_local_repo = path_to_local_repo))

        }
