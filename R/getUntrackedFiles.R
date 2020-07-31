#' List Untracked Files
#' @description This function lists all the untracked files in a local repo.
#' @return If untracked files exist, a vector of all the untracked file paths.
#' @importFrom secretary typewrite
#' @export


lsUntrackedFiles <-
        function(path_to_local_repo = NULL) {

                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Untracked files:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage$`Untracked files:` %>%
                                                trimws(which = "both")

                } else {

                        secretary::typewrite("No untracked files in", path_to_local_repo)

                }
        }
