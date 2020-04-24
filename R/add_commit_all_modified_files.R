#' Add and Commit Modified Files
#' @description Adds and commits all modified files one-by-one in the local repo with
#' a commit message that states that the file was committed automatically using this function.
#' @param path_to_local_repo path to local repo
#' @export

add_commit_all_modified_files <-
        function(path_to_local_repo) {
                modified_files <- modified_files(path_to_local_repo = path_to_local_repo)
                while(length(modified_files) > 0) {
                        fn <- modified_files[1]
                        full_fn <- paste0(path_to_local_repo, "/", fn)
                                pretty_if_exists(
                                        add_commit_some(path_to_local_repo = path_to_local_repo,
                                                                 filenames = fn,
                                                                 commit_message = paste0("auto-added modified ", fn, " via glitter from ", cave::present_script_path())))

                        modified_files <- modified_files[-1]
                }
        }



