#' Get the Git status of the current working directory
#' @description This function differs from status() by the fact that the system command does not set a path to a given local repo, but uses the path that is the working directory.
#' @return If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @export


wd_status <-
        function() {
                        x <- system("git status", intern = TRUE)
                        pretty_if_exists(x)
                        invisible(x)
        }
