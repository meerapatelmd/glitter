#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @export


add_all_this_repo <-
        function() {
                        x <- system("git add .", intern = TRUE)
                        return(x)

        }
