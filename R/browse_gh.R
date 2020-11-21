#' @title
#' Browse GitHub
#'
#' @param github_user       GitHub username
#' @param repo                  Repository belonging to the GitHub user
#' @param issue_no              Issue Number
#'
#' @name browse_github
NULL

#' @inheritParams browse_github
#' @export

get_issues_page_url <-
        function(github_user,
                 repo) {

                sprintf("https://github.com/%s/%s/issues",
                        github_user,
                        repo)
        }

#' @inheritParams browse_github
#' @export

get_repo_url <-
        function(github_user,
                 repo) {

                sprintf("https://github.com/%s/%s",
                        github_user,
                        repo)
        }

#' @inheritParams browse_github
#' @export

get_gh_pages_url <-
        function(github_user,
                 repo) {

                sprintf("https://%s.github.io/%s",
                        github_user,
                        repo)
        }

#' @inheritParams browse_github
#' @export

browse_repo <-
        function(github_user,
                 repo) {

                repo_url <- get_repo_url(github_user = github_user,
                                                 repo = repo)

                browseURL(url = repo_url)
        }

#' @inheritParams browse_github
#' @export

browse_gh_pages <-
        function(github_user,
                 repo) {

                gh_pages_url <- get_gh_pages_url(github_user = github_user,
                                                     repo = repo)

                browseURL(url = gh_pages_url)
        }

#' @inheritParams browse_github
#' @export

browse_issues <-
        function(github_user,
                 repo,
                 issue_no = NULL) {


                issues_page_url <- get_issues_page_url(github_user = github_user,
                                                       repo = repo)

                if (!is.null(issue_no)) {

                        issues_page_url <- sprintf("%s/issue_no",
                                                   issues_page_url,
                                                   issue_no)

                }

                browseURL(issues_page_url)

        }
