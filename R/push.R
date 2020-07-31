#' Push a local repo to a GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @export


push <-
        function(path_to_local_repo = NULL,
                 remote_name = "origin",
                 remote_branch = "master") {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }



                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                if (any(grepl('use "git push" to publish your local commits', statusMessage))) {
                        x <-
                                system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git push ", remote_name, " ", remote_branch),
                                       intern = TRUE)

                        printMsg(x)

                }

        }
