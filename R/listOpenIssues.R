#' List Open GitHub Issues
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
                                       regex = "^[ ]+?([0-9]+?)[ ]+?([^ ]{1}.*$)")

                invisible(output)

        }
