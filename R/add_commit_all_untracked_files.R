#' Add and Commit Untracked Files
#' @description Adds and commits all untracked files one-by-one in the local repo with a commit message that states that the file was committed automatically using this function.
#' @param path_to_local_repo path to local repo
#' @export

add_commit_all_untracked_files <-
        function(path_to_local_repo) {
                untracked_files <- untracked_files(path_to_local_repo = path_to_local_repo)
                while(length(untracked_files) > 0) {
                        fn <- untracked_files[1]
                        full_fn <- paste0(path_to_local_repo, "/", fn)
                                pretty_if_exists(
                                        add_commit_some(path_to_local_repo = path_to_local_repo,
                                                                 filenames = fn,
                                                                 commit_message = paste0("new file auto-added and committed via glitter ", fn)))

                        untracked_files <- untracked_files[-1]
                }
        }

