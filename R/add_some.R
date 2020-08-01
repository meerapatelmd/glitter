#' Add Some Files to a Commit
#' @description This function takes a vector of filenames, filters them for only the untracked and unstaged files, and adds them to a commit.
#' @param path_to_local_repo full path to local repository to be pushed
#' @import purrr
#' @export


add_some <-
        function(path_to_local_repo = NULL,
                 filenames,
                 verbose = TRUE) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)



                filenames <- filenames[filenames %in% lsFilesToCommit(path_to_local_repo = path_to_local_repo)]
                output <-
                filenames %>%
                        purrr::map(function(x) add_file(path_to_local_repo = path_to_local_repo,
                                             file = x,
                                             verbose = FALSE)) %>%
                        purrr::keep(~!is.null(.))


                if (verbose) {

                        printMsg(output)

                }


                if (length(output)) {

                        invisible(output)

                }

}
