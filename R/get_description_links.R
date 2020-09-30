#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param github_username PARAM_DESCRIPTION
#' @param repo PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname get_description_links
#' @export


get_description_links <-
        function(github_username,
                 repo) {


                repo_attributes <- get_repo_info(github_username = github_username,
                                                 repo = repo,
                                                 as_list = TRUE)

                c(paste0("URL: ", paste(repo_attributes$pages_url, paste0(repo_attributes$html_url, "/"), sep = ", ")),
                     paste0("BugReports: ", paste0(repo_attributes$issues_page_url, "/"))) %>%
                        cat(sep = "\n")

        }
