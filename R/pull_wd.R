#' Pull a remote GitHub repo from working directory
#' @description Performs a simple pull based on the path set by the current working directory
#' @export

pull_wd <-
        function() {
                        x <- system("git pull", intern = TRUE)
                        return(x)
        }
