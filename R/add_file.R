#' Add a single file to a commit
#' @description This function is a primitive function to wrap add_some() around.
#' @param path_to_local_repo full path to local repository to be pushed
#' @importFrom typewriteR tell_me
#' @importFrom crayon yellow
#' @export


add_file <-
        function(path_to_local_repo = NULL,
                 file,
                 verbose = TRUE) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }


                if (!(file %in% lsUnstagedFiles(path_to_local_repo = path_to_local_repo))) {

                        stop(file, " not found in ", path_to_local_repo)

                }


                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                file_size <- cave::size_in_mb(paste0(path_to_local_repo, "/", file)) %>%
                                                centipede::no_na()


                if (length(file_size)) {
                        if (file_size > 1) {
                                stop(file, " is greater than 100 MB.")
                        }
                }


                gitMessage <-
                        file %>%
                        formatCli() %>%
                        purrr:::map(function(x) system(paste0("cd\n",
                                                              "cd ", path_to_local_repo,"\n",
                                                              "git add ", x),
                                                       intern = TRUE)) %>%
                                unlist()

                if (verbose) {
                        printMsg(gitMessage)
                }

                if (length(gitMessage)) {
                        invisible(gitMessage)
                }

        }
