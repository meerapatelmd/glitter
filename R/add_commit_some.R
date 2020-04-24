#' Push a local repo to remote GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param commit_message defaults to NULL, where the commit_message is a "modify/add {filename} in {path to present R script}"
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_commit_some <-
        function(path_to_local_repo, filenames, commit_message = NULL, description = NULL) {
                if (dir.exists(path_to_local_repo)) {

                        for (i in 1:length(filenames)) {
                                fn <- sanitize_fns_for_cli(filenames[i])
                                x <- system(paste0("cd\n",
                                                                 "cd ", path_to_local_repo,"\n",
                                                                 "git add ", fn),
                                                           intern = TRUE)
                        }

                        if (!is.null(commit_message)) {
                                x <-
                                        commit(path_to_local_repo = path_to_local_repo,
                                               commit_message = commit_message,
                                               description = description)

                        } else {
                                x <-
                                        commit(path_to_local_repo = path_to_local_repo,
                                               commit_message = paste0("add/modify ", paste(filenames, collapse = ", "), " written in ", cave::present_script_path()),
                                               description = description)
                        }

                        if (length(x) > 0) {
                                pretty(x)
                                return(x)
                        }

                } else {
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
