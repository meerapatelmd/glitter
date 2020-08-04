#' GitHub Issues
#' @description https://github.com/stephencelis/ghi
#' @export

listOpenIssues <-
        function(repo = NULL) {

                if (is.null(repo)) {

                        repo <- getwd()

                }

                system(paste0("cd\n",
                              "cd ", repo,"\n",
                              "/usr/local/bin/ghi list"),
                       intern = FALSE)


                output <-
                        tibble::tibble(Issues = system(paste0("cd\n",
                                                     "cd ", repo,"\n",
                                                     "/usr/local/bin/ghi list"),
                                                        intern = TRUE)[-1]) %>%
                        tidyr::extract(col = Issues,
                                       into = c("IssueNo",
                                                "OpenIssue"),
                                       regex = "(^[ ]{0,}[0-9]{1,}[ ]*?)([a-zA-Z]{1,}.*$)") %>%
                        dplyr::mutate_all(trimws, "both")

                invisible(output)

        }

#' GitHub Issues
#' @description https://github.com/stephencelis/ghi
#' @export

listClosedIssues <-
        function(repo = NULL) {

                if (is.null(repo)) {

                        repo <- getwd()

                }

                system(paste0("cd\n",
                              "cd ", repo,"\n",
                              "ghi close --list"),
                       intern = FALSE)


                output <-
                        tibble::tibble(Issues = system(paste0("cd\n",
                                                              "cd ", repo,"\n",
                                                              "ghi close --list"),
                                                       intern = TRUE)[-1]) %>%
                        tidyr::extract(col = Issues,
                                       into = c("IssueNo",
                                                "ClosedIssue"),
                                       regex = "(^[ ]{0,}[0-9]{1,}[ ]*?)([a-zA-Z]{1,}.*$)") %>%
                        dplyr::mutate_all(trimws, "both")

                invisible(output)
        }


#' Open a GitHub Issue
#' @description This function opens a GitHub Issue from the R console.
#' @export

openIssue <-
        function(repo = NULL,
                 title,
                 description) {

                if (is.null(repo)) {

                        repo <- getwd()

                }

                prompt <-
                paste0("cd\n",
                       "cd ", repo,"\n",
                       "ghi open -m '", description, "' \ '", title, "'")

                system(prompt)
        }


#' Close a GitHub Issue
#' @description This function closes a GitHub Issue from the R console.
#' @export

closeIssue <-
        function(repo = NULL,
                 issueNo,
                 closureMsg) {

                if (is.null(repo)) {

                        repo <- getwd()

                }

                prompt <-
                        paste0("cd\n",
                               "cd ", repo,"\n",
                               "ghi close -m '", closureMsg, "' \ '", closureMsg, "' ", issueNo)

                system(prompt)
        }


#' Show a GitHub Issue
#' @description This function shows a GitHub Issue from the R console.
#' @export

showIssue <-
        function(repo = NULL,
                 issueNo) {

                if (is.null(repo)) {

                        repo <- getwd()

                }

                prompt <-
                        paste0("cd\n",
                               "cd ", repo,"\n",
                               "ghi show ", issueNo)

                system(prompt)
        }
