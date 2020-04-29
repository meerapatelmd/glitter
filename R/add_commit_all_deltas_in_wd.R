#' Adds and commits all changed files in the current wd
#' @export


add_commit_all_deltas_in_wd <-
        function(commit_message = NULL, description = NULL) {
                all_deltas <- all_file_deltas_in_wd()

                git_msg <-
                        add_commit_some(path_to_local_repo = getwd(),
                                        filenames = all_deltas,
                                        commit_message = commit_message)

                pretty_if_exists(git_msg = git_msg)
                invisible(git_msg)
        }
