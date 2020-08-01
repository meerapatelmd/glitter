#' Git Diff
#' @description Show unstaged changes between your index and working directory
#' @export


diff <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                diffMessage <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git diff"
                        ), intern = TRUE
                        )

                printMsg(diffMessage)

        }
