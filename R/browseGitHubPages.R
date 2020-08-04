#' Browse a Package's GitHub Page
#' @export


browseGitHubPages <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }
                #Installing package by first getting URL of the remote
                git_url <- remote_url(path_to_local_repo = path_to_local_repo)

                #Installing it as either a public or an Enterprise GitHub repo
                if (grepl("github.com/patelm9", git_url, ignore.case = TRUE) == TRUE) {
                        browseURL(url = paste0("https://patelm9.github.io/", basename(path_to_local_repo), "/index.html"))
                }
        }
