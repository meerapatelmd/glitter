#' Get Git Remote URL
#' @param remote_name Name of the remote. Defaults to "Origin".
#' @return url of the remote as a string
#' @export

remote_url <-
        function(remote_name = "origin") {
                system(paste0("git remote get-url ", remote_name), intern = TRUE)
        }
