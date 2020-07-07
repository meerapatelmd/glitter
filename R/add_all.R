#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_all <-
        function(path_to_local_repo = NULL) {

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()
                        }



                        stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                        stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                        system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git add ."),
                                       intern = FALSE)

        }
