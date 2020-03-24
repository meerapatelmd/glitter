#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @export


status_this_repo <-
        function() {
                        x <- system("git status", intern = TRUE)
                        return(x)

        }
