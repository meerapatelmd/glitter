#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param commit_message message to be included in the commit
#' @export


commit_this_repo <-
        function(commit_message, description = NULL) {
                if (is.null(description)) {
                        x <- system(paste0("git commit -m '", commit_message, "'"), intern = TRUE)
                        return(x)
                } else {
                        x <- system(paste0("git commit -m '", commit_message, "' ", "-m '", description, "'"), intern = TRUE)
                        return(x)
                }
        }
