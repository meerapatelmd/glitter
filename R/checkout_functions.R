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
