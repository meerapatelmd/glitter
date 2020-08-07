#' @title List Open GitHub Issues
#' @description
#' All GitHub Issues functions in this package requires downloading and setting up authorization for \href{https://github.com/stephencelis/ghi}{GHI}.
#' @param repo path to the local repo targeted by the function call. If NULL, the function is executed on the working directory
#' @return The system command stdout is printed in the R console and a dataframe from that same data is returned invisibly.
#' @details DETAILS
#' @seealso
#'  \code{\link[tibble]{tibble}}
#'  \code{\link[rubix]{filter_at_grepl}}
#'  \code{\link[tidyr]{extract}}
#'  \code{\link[dplyr]{filter}}
#' @rdname listOpenIssues
#' @importFrom tibble tibble
#' @importFrom rubix filter_at_grepl
#' @importFrom tidyr extract
#' @importFrom dplyr filter
#' @importFrom magrittr %>%
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
                        # Converting the vector of issues into a dataframe
                        tibble::tibble(Issues = system(paste0("cd\n",
                                                              "cd ", repo,"\n",
                                                              "/usr/local/bin/ghi list"),
                                                       intern = TRUE))  %>%
                        # Removing theheader to isolate the issue number and issue name
                        rubix::filter_at_grepl(Issues,
                                               grepl_phrase = "[#]{1}.*open issues$",
                                               evaluates_to = FALSE)  %>%
                        tidyr::extract(col = Issues,
                                       into = c("IssueNo",
                                                "OpenIssue"),
                                       regex = "^[ ]+?([0-9]+?)[ ]+?([^ ]{1}.*$)") %>%
                        #Filter out all NA
                        dplyr::filter(!is.na(IssueNo))

                invisible(output)

        }

#' List Closed Issues
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
