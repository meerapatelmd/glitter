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





#' Delete a Branch
#' @description Delete a branch.
#' @param branch Name of branch to delete
#' @export


delete_branch <-
        function(path_to_local_repo = NULL,
                 branch) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                system(paste0("cd\n",
                              "cd ", path_to_local_repo,"\n",
                              "git checkout -d ", branch),
                       intern = FALSE)


        }


#' @title
#' Checkout a Branch
#'
#' @param branch Name of the new branch
#'
#' @export


checkout_branch <-
        function(branch,
                 path_to_local_repo = NULL) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)


                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          paste0("git checkout ", branch)) %>%
                        paste(collapse = "\n")


                system(command = command,
                       intern = FALSE)

        }

#' @title
#' Checkout a New Branch
#'
#' @description
#' Print all the branches and the current branch in a GitHub repository
#'
#' @param new_branch Name of the new branch
#'
#' @export


checkout_new_branch <-
        function(new_branch,
                 path_to_local_repo = NULL) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)


                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          paste0("git checkout -b ", new_branch)) %>%
                        paste(collapse = "\n")


                system(command = command,
                       intern = FALSE)

        }











