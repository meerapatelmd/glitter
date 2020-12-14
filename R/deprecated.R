#' @title (Deprecated) List Open GitHub Issues
#' @description
#' (Deprecated) All GitHub Issues functions in this package requires downloading and setting up authorization for \href{https://github.com/stephencelis/ghi}{GHI}.
#' @param path path to the local path targeted by the function call. If NULL, the function is executed on the working directory
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
        function(path = getwd()) {

                .Deprecated()

                system(paste0("cd\n",
                              "cd ", path,"\n",
                              "/usr/local/bin/ghi list"),
                       intern = FALSE)


                output <-
                        # Converting the vector of issues into a dataframe
                        tibble::tibble(Issues = system(paste0("cd\n",
                                                              "cd ", path,"\n",
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

#' (Deprecated) List Closed Issues
#' @export
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom tidyr extract
#' @importFrom dplyr mutate_all
#' @description
#' (Deprecated)

listClosedIssues <-
        function(path = getwd()) {

                .Deprecated()

                system(paste0("cd\n",
                              "cd ", path,"\n",
                              "ghi close --list"),
                       intern = FALSE)


                output <-
                        tibble::tibble(Issues = system(paste0("cd\n",
                                                              "cd ", path,"\n",
                                                              "ghi close --list"),
                                                       intern = TRUE)[-1]) %>%
                        tidyr::extract(col = Issues,
                                       into = c("IssueNo",
                                                "ClosedIssue"),
                                       regex = "(^[ ]{0,}[0-9]{1,}[ ]*?)([a-zA-Z]{1,}.*$)") %>%
                        dplyr::mutate_all(trimws, "both")

                invisible(output)
        }


#' (Deprecated) Open a GitHub Issue
#' @description (Deprecated) This function opens a GitHub Issue from the R console.
#' @export

openIssue <-
        function(path = getwd(),
                 title,
                 description) {

                .Deprecated()

                prompt <-
                paste0("cd\n",
                       "cd ", path,"\n",
                       "ghi open -m '", description, "' \ '", title, "'")

                system(prompt)
        }


#' (Deprecated) Close a GitHub Issue
#' @description (Deprecated) This function closes a GitHub Issue from the R console.
#' @export

closeIssue <-
        function(path = getwd(),
                 issueNo,
                 closureMsg) {

                .Deprecated()

                prompt <-
                        paste0("cd\n",
                               "cd ", path,"\n",
                               "ghi close -m '", closureMsg, "' \ '", closureMsg, "' ", issueNo)

                system(prompt)
        }


#' (Deprecated) Show a GitHub Issue
#' @description (Deprecated) This function shows a GitHub Issue from the R console.
#' @export

showIssue <-
        function(path = getwd(),
                 issueNo) {

                .Deprecated()

                prompt <-
                        paste0("cd\n",
                               "cd ", path,"\n",
                               "ghi show ", issueNo)

                system(prompt)
        }
