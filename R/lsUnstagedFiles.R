#' List Unstaged Files
#' @description This function lists all the unstaged files in a local repo.
#' @return If unstaged files exist, a vector of all the untracked file paths.
#' @importFrom secretary typewrite
#' @export


lsUnstagedFiles <-
        function(path_to_local_repo = NULL,
                 modified = TRUE,
                 deleted = TRUE) {

                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Changes not staged for commit:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage <-
                        parsedStatusMessage$`Changes not staged for commit:` %>%
                                                trimws(which = "both") %>%
                                                sort()

                        c(
                        parsedStatusMessage %>%
                                purrr::keep(~((modified == TRUE) & grepl("modified[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((deleted == TRUE) & grepl("deleted[:]", .))))

                } else {

                        secretary::typewrite("No unstaged files in", path_to_local_repo)

                }
        }
