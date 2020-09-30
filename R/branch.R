#' Git Branch
#' @description
#' Print all the branches and the current branch in a GitHub repository
#' @export


branch <-
        function(verbose = TRUE,
                 path_to_local_repo = NULL) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                branch_response <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git branch"),
                               intern = TRUE)


                if (verbose) {
                        cat("\n")
                        secretary::typewrite_bold(secretary::redTxt("\tBranches:"))
                        cat(paste0("\t\t", branch_response), sep = "\n")
                        cat("\n")
                }

        }
