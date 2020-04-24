#' Add and commit all modified and untracked files in the current working directory
#' @param commit_message defaults to NULL, where the commit_message is a "modify/add {filename} in {path to present R script}"
#' @export


wd_add_commit_all <-
        function(commit_message = NULL, description = NULL) {
                filenames <- wd_files_to_commit()

                wd_add_commit_some(path_to_local_repo = getwd(),
                                        filenames = filenames,
                                        commit_message = commit_message,
                                        description = description)
        }
