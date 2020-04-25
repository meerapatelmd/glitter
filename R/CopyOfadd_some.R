#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_some <-
        function(path_to_local_repo, filenames) {
                if (dir.exists(path_to_local_repo)) {

                        for (i in 1:length(filenames)) {
                                fn <- sanitize_fns_for_cli(filenames[i])
                                x <- system(paste0("cd\n",
                                                                 "cd ", path_to_local_repo,"\n",
                                                                 "git add ", fn),
                                                           intern = TRUE)
                        }

                } else {
                        typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                }
        }
