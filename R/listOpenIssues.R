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
