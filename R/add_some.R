#' Push a local repo to remote MSK KMI Enterprise GitHub repository
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


                output <-
                filenames %>%
                        purrr::map(~add_file(path_to_local_repo = path_to_local_repo,
                                             file = .,
                                             verbose = TRUE)) %>%
                        purrr::keep(~!is.null(.))


                if (verbose) {

                        printMsg(output)

                }


                if (length(output)) {

                        invisible(output)

                }

}
