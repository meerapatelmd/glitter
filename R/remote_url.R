#' Get Git Remote URL
#' @param remote_name Name of the remote. Defaults to "Origin".
#' @return url of the remote as a string
#' @export

remote_url <-
        function(path_to_local_repo = NULL,
                 remote_name = "origin") {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                suppressWarnings(
                system(paste0("cd\n",
                              "cd ", path_to_local_repo,"\n",
                              "git remote get-url ", remote_name),
                       ignore.stderr = TRUE,
                       intern = TRUE)
                )
        }
