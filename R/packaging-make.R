#' @title
#' Make Links to Add to DESCRIPTION
#'
#' @inheritParams browse_gh
#'
#' @example inst/examples/packaging-make.R
#'
#' @rdname makeDescriptionLinks
#' @export


makeDescriptionLinks <-
        function(github_user,
                 repo) {

                gh_pages_url <- get_gh_pages_url(github_user = github_user,
                                                 repo = repo)
                repo_url <- get_repo_url(github_user = github_user,
                                         repo = repo)

                issues_url <- get_issues_page_url(github_user = github_user,
                                                  repo = repo)

                c(URL = sprintf("URL: %s/, %s/", gh_pages_url, repo_url),
                     BugReports = sprintf("BugReports: %s/", issues_url)) %>%
                        paste(collapse = "\n") %>%
                        cat()

        }
