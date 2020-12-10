#' Git Branch
#' @description
#' Print all the branches and the current branch in a GitHub repository
#' @export


branch <-
        function(verbose = TRUE,
                 path = getwd()) {

                branch_response <-
                        system(paste0("cd\n",
                                      "cd ", path,"\n",
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
#' @param force If TRUE, a `-D` delete is performed in lieu of `-d`
#' @export


delete_branch <-
        function(path = getwd(),
                 branch,
                 force = FALSE) {


                if (force) {

                        system(paste0("cd\n",
                                      "cd ", path,"\n",
                                      "git checkout -D ", branch),
                               intern = FALSE)


                } else {

                        system(paste0("cd\n",
                                      "cd ", path,"\n",
                                      "git checkout -d ", branch),
                               intern = FALSE)

                }


        }


#' @title
#' Checkout a Branch
#'
#' @param branch Name of the new branch
#'
#' @export


checkout_branch <-
        function(branch,
                 path = getwd()) {

                command <-
                        c(starting_command(path = path),
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
                 path = getwd()) {


                command <-
                        c(starting_command(path = path),
                          paste0("git checkout -b ", new_branch)) %>%
                        paste(collapse = "\n")


                system(command = command,
                       intern = FALSE)

        }











