#' List Unstaged Files
#' @description This function lists all the unstaged files in a local repo.
#' @return If unstaged files exist, a vector of all the untracked file paths.
#' @seealso
#'  \code{\link[purrr]{keep}}
#'  \code{\link[stringr]{str_replace}}
#'  \code{\link[secretary]{typewrite}}
#' @rdname lsUnstagedFiles
#' @export
#' @importFrom magrittr %>%
#' @importFrom purrr keep
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite

lsUnstagedFiles <-
        function(path_to_local_repo = NULL,
                 modified = TRUE,
                 deleted = TRUE,
                 label = FALSE) {

                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Changes not staged for commit:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage <-
                        parsedStatusMessage$`Changes not staged for commit:` %>%
                                                trimws(which = "both") %>%
                                                sort()

                        output <-
                        c(
                        parsedStatusMessage %>%
                                purrr::keep(~((modified == TRUE) & grepl("modified[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((deleted == TRUE) & grepl("deleted[:]", .))))

                        if (label) {
                                return(output)
                        } else {
                                stringr::str_replace_all(output,
                                                         "(^.*?[:]{1})([ ]{1,})(.*$)",
                                                         "\\3")
                        }

                } else {

                        secretary::typewrite("No unstaged files in", path_to_local_repo)

                }
        }
