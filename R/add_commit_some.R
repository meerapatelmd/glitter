#' Add and Commit Some Files
#' @param path_to_local_repo full path to local repository to be pushed
#' @param filenames names of files in the local repository path to be committed
#' @param commit_message defaults to NULL, where the commit_message is a "change to {filename} in {path to present R script}"
#' @export


add_commit_some <-
        function(
                 filenames,
                 commit_message = NULL,
                 description = NULL,
                 verbose = TRUE,
                 path_to_local_repo = NULL) {

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                        }

                        add_some(path_to_local_repo = path_to_local_repo,
                                                                filenames = filenames)


                        commit(path_to_local_repo = path_to_local_repo,
                               commit_message = commit_message,
                               description = description,
                               verbose = verbose
                        )
        }
