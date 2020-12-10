#' See the history of your commits in a graph
#' @export

commit_graph <-
        function(path = getwd(),
                 verbose = TRUE) {


                logResponse <- system(paste0("cd\n", "cd ", path, "\n git log --oneline --graph --all"), intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }
