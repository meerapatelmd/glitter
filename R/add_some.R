#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_some <-
        function(path_to_local_repo = NULL, filenames) {
                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                x <-
                        filenames %>%
                        purrr::map(format_for_cli) %>%
                        purrr:::map(function(x) system(paste0("cd\n",
                                                              "cd ", path_to_local_repo,"\n",
                                                              "git add ", x),
                                                       intern = TRUE))


                # x %>%
                #         purrr::keep(!is.null(.)) %>%
                #         purrr::map(~print_if_has_length(.))



                # if (dir.exists(path_to_local_repo)) {
                #
                #         for (i in 1:length(filenames)) {
                #                 fn <- sanitize_fns_for_cli(filenames[i])
                #                 x <- system(paste0("cd\n",
                #                                                  "cd ", path_to_local_repo,"\n",
                #                                                  "git add ", fn),
                #                                            intern = TRUE)
                #         }
                #
                # } else {
                #         typewriteR::tell_me(crayon::yellow("\tError: Local repository", path_to_local_repo, "does not exist."))
                # }
        }
