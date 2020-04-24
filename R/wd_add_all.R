#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @export


wd_add_all <-
        function() {
                        x <- system("git add .", intern = TRUE)
                        pretty_if_exists(x)

        }
