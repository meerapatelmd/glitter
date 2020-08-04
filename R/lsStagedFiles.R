#' List Staged Files
#' @description This function lists all the staged files in a local repo.
#' @return If staged files exist, a vector of all the staged file paths.
#' @param label If TRUE, returns the results with prefix of "modified:|deleted:|new file: {file path}"
#' @importFrom magrittr %>%
#' @importFrom secretary typewrite
#' @export


lsStagedFiles <-
        function(path_to_local_repo = NULL,
                 modified = TRUE,
                 deleted = TRUE,
                 new_file = TRUE,
                 renamed = TRUE,
                 label = FALSE) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }


                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Changes to be committed:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage <-
                        parsedStatusMessage$`Changes to be committed:` %>%
                                                trimws(which = "both") %>%
                                                sort()


                        output <-
                        c(
                        parsedStatusMessage %>%
                                purrr::keep(~((modified == TRUE) & grepl("modified[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((deleted == TRUE) & grepl("deleted[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((new_file == TRUE) & grepl("new file[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((renamed == TRUE) & grepl("renamed[:]", .))) %>%
                                purrr::map(~stringr::str_replace_all(., "(^.*?[-]{1}[>]{1} )(.*$)", "\\2")))

                        if (label) {
                                return(output)
                        } else {
                                stringr::str_replace_all(output,
                                                         "(^.*?[:]{1})([ ]{1,})(.*$)",
                                                         "\\3")
                        }



                } else {

                        secretary::typewrite("No staged files in", path_to_local_repo)

                }
        }
