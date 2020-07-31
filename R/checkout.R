#' Checkout a Branch
#' @description Print all the branches and the current branch in a GitHub repository
#' @param branch Name of branch to checkout
#' @export


checkout <-
        function(path_to_local_repo = NULL,
                 branch) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                system(paste0("cd\n",
                              "cd ", path_to_local_repo,"\n",
                              "git checkout -b ", branch),
                       intern = FALSE)


        }
