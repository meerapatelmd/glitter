#' Add and Commit All Changes in a Local Repository
#' @param path_to_local_repo full path to local repository where the add and commit all will be performed
#' @param commit_message If NULL, automatically creates a message in the format of "add/modify {filename} as written in {R script path}"
#' @param description additional optional description
#' @importFrom secretary typewrite_italic
#' @export


add_commit_all <-
        function(path_to_local_repo = NULL,
                 commit_message,
                 description = NULL,
                 verbose = TRUE) {

                add_all(path_to_local_repo = path_to_local_repo)

                commit(path_to_local_repo = path_to_local_repo,
                       commit_message = commit_message,
                       description = description,
                       verbose = verbose
                       )
        }

