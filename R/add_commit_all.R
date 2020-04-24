#' Add and commit all changes in a local repo
#' @param path_to_local_repo full path to local repository where the add and commit all will be performed
#' @param commit_message If NULL, automatically creates a message in the format of "add/modify {filename} as written in {R script path}"
#' @param description additional optional description
#' @importFrom secretary typewrite_italic
#' @export


add_commit_all <-
        function(path_to_local_repo,
                 commit_message = NULL,
                 description = NULL) {

                filenames <- files_to_commit(path_to_local_repo = path_to_local_repo)

                git_message <- add_commit_some(path_to_local_repo = path_to_local_repo,
                                filenames = filenames,
                                commit_message = commit_message,
                                description = description)

                if (length(git_message) > 0) {
                        pretty_if_exists(git_message)
                        invisible(git_message)
                } else {
                        secretary::typewrite_italic("Nothing to and and commit.")
                }
        }

