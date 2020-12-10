#' Destroy all traces of a file accidentally pushed to a public repo. This requires creating a fresh local clone of the repo to rewrite history. This function does not alter the repo from the command line, but rather returns the CLI commands to do so
#' @param path_to_local_repo_clone path to a clone of the local repo
#' @keywords internal
#' @export

filter_repo <-
        function(path_to_local_repo_clone, destroy_this_file) {

                destroy_this_file <- sanitize_fns_for_cli(destroy_this_file)
                path_to_local_repo <- path_to_local_repo_clone

                # path_to_file <- paste0(path_to_local_repo, "/", destroy_this_file)
                # if (file.exists(path_to_file)) {
                #         file.remove(path_to_file)
                #
                #         pretty_if_exists(
                #                 add_commit_all(path_to_local_repo = path_to_local_repo,
                #                                commit_message = paste0("delete ", destroy_this_file)))
                #
                #         pretty_if_exists(push(path_to_local_repo = path_to_local_repo))
                # }

                        cat(paste0("cd\n",
                               "cd ", path_to_local_repo,"\n",
                               "git filter-repo --path ", destroy_this_file, " --invert-paths"))

        }


