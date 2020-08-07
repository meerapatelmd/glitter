#' Git Branch
#' @description
#' Print all the branches and the current branch in a GitHub repository
#' @export


branch <-
        function(verbose = TRUE,
                 path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                branchResponse <-
                system(paste0("cd\n",
                              "cd ", path_to_local_repo,"\n",
                              "git branch"),
                       intern = TRUE)


                if (verbose) {
                        printMsg(branchResponse)
                }

                invisible(branchResponse)


        }
