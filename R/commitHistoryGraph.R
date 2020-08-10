#' See the history of your commits in a graph
#' @export

commitHistoryGraph <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                logResponse <- system(paste0("cd\n", "cd ", path_to_local_repo, "\n git log --oneline --graph --all"), intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }
