#' Pull a GitHub repo based on the path to local repo
#' @export

git_pull_this_repo <-
        function() {
                        x <- system("git pull", intern = TRUE)
                        return(x)
        }
