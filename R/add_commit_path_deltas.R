#' Adds and commits all changed files in a given path
#' @description This function combines outputs for
#' @export


add_commit_path_deltas <-
        function(path, commit_message = NULL, description = NULL) {
                all_deltas <- c(modified_files(path_to_local_repo = path),
                                untracked_files(path_to_local_repo = path),
                                deleted_files(path_to_local_repo = path))

                all_deltas_in_path <- grep("^[.]{2}", all_deltas, invert = TRUE, value = TRUE)

                git_msg <-
                        add_commit_some(path_to_local_repo = path,
                                        filenames = all_deltas_in_path,
                                        commit_message = commit_message)

                pretty_if_exists(git_msg = git_msg)
                invisible(git_msg)
        }
