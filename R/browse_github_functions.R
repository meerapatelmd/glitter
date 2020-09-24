#' @title
#' Browse GitHub Functions
#'
#' @description
#' These functions open up GitHub urls related to a repo in the browser returned by \code{\link{get_remote_urls}}.
#'
#' @param github_username       GitHub username
#' @param repo                  Repository belonging to the GitHub user
#'
#' @name browse_github_functions
NULL


#' @title
#' Open a GitHub Page in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @return
#' If a GitHub Page exists, it is opened in the browser. Otherwise, a message is returned in the console that states that a GitHub Page does not exist.
#'
#' @details
#' This function opens the GitHub Page URL returned by \code{\link{get_remote_urls}} if a GitHub Page exists for the repo.
#'
#' @seealso
#'  \code{\link[dplyr]{filter}}
#'  \code{\link[secretary]{typewrite}}
#'  \code{\link[utils]{browseURL}}
#' @rdname browse_gh_pages
#' @family browse github
#' @export
#' @importFrom dplyr filter
#' @importFrom secretary typewrite
#' @importFrom utils browseURL

browse_gh_pages <-
        function(github_username,
                 repo) {

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }

                repo_pages_info <-
                        repo_info %>%
                        dplyr::filter(has_pages == "TRUE")


                if (nrow(repo_pages_info) == 0) {

                        secretary::typewrite(repo, "does not have a GitHub Page.")

                } else {

                        utils::browseURL(url = repo_pages_info$pages_url)

                }

        }


#' @title
#' Open a GitHub Repo URL in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @seealso
#'  \code{\link[utils]{browseURL}}
#' @rdname browse_repo_issues
#' @family browse github
#' @export
#' @importFrom utils browseURL

browse_repo_issues <-
        function(github_username,
                 repo) {

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }


                utils::browseURL(url = repo_info$issues_page_url)


        }


#' @title
#' Open a GitHub Repo Issues Page in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @seealso
#'  \code{\link[utils]{browseURL}}
#' @rdname browse_repo_issues
#' @export
#' @importFrom utils browseURL

browse_repo <-
        function(github_username,
                 repo) {

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }


                utils::browseURL(url = repo_info$html_url)


        }
