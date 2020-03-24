#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @export

add_some_this_repo <-
        function(filenames) {
                x <- vector()
                for (i in 1:length(filenames)) {
                        x[i] <- system(paste0("git add ", filenames[i]), intern = TRUE)
                }
                return(x)
        }
