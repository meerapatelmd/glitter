#' @title
#' Make an API Call for a GitHub User's Remote Repositories
#'
#' @description
#' Make an API call to the GitHub API to retrieve all the repository information for a itHub User. All native fields in the JSON response are preserved with all the url fields returned with a terminal curly bracketed field such as "{/id}" are mutated with a corresponding "page" field with that terminal pattern removed to directly open the path in the browser if desired. Additionally, an "issues_page_url" and a "pages_url" fields are added for a direct url to the repository's issues page and GitHub Pages site, respectively. The url to the GitHub Pages is derived on that condition that the `has_pages` field is TRUE for that repository. The value in this field is `NA` if a GitHub Page does not exist for the repo. The same is done with the "issues_page_url" path except that no logic is applied since all GitHub repos will have an Issues page by default.
#'
#' @param github_user       GitHub username. Enterprise GitHub is not supported.
#'
#' @return
#' JSON response parsed into a tibble.
#'
#' @seealso
#'  \code{\link[httr]{GET}},\code{\link[httr]{http_error}},\code{\link[httr]{status_code}},\code{\link[httr]{content}}
#'  \code{\link[jsonlite]{toJSON, fromJSON}}
#'  \code{\link[tibble]{rownames}},\code{\link[tibble]{as_tibble}}
#'  \code{\link[dplyr]{select}},\code{\link[dplyr]{reexports}},\code{\link[dplyr]{mutate_all}},\code{\link[dplyr]{vars}},\code{\link[dplyr]{select_all}},\code{\link[dplyr]{mutate-joins}},\code{\link[dplyr]{mutate}}
#'  \code{\link[stringr]{str_replace}}
#' @rdname get_repos
#' @family github api functions
#' @export
#' @importFrom httr GET http_error status_code content
#' @importFrom jsonlite fromJSON
#' @importFrom tibble rowid_to_column as_tibble
#' @importFrom dplyr select ends_with mutate_at vars rename_at left_join mutate everything
#' @importFrom stringr str_replace_all


get_repos <-
        function(github_user,
                 per_page = 100,
                 page = 1) {

                github_url <- sprintf("https://api.github.com/users/%s/repos", github_user)

                resp <- httr::GET(github_url,
                                  query = list(per_page = per_page,
                                               page = page))


                if (httr::http_error(resp)) {

                        parsed <- httr::content(resp, type = "application/json")
                        stop(
                                sprintf(
                                        "GitHub API request failed [%s]\n%s\n<%s>",
                                        httr::status_code(resp),
                                        parsed$message,
                                        parsed$documentation_url
                                ),
                                call. = FALSE
                        )
                }

                parsed <- httr::content(resp, type = "application/json", as = "text", encoding = "UTF-8")
                output <- jsonlite::fromJSON(txt = parsed)

                # add row identifier to do a join with modified fields
                output <-
                        output %>%
                        tibble::rowid_to_column(var = "rowid")

                # Create Page HTML Paths from the `url fields` that can be opened in the browser
                output_b <-
                output %>%
                        dplyr::select(rowid, dplyr::ends_with("_url")) %>%
                        dplyr::mutate_at(dplyr::vars(!rowid), ~ stringr::str_replace_all(string = .,
                                                                                         pattern = "(^.*?)([{]{1}.*$)",
                                                                                         replacement = "\\1")) %>%
                        dplyr::rename_at(dplyr::vars(!rowid), function(x) stringr::str_replace_all(string = x,
                                                                                                   pattern = "_url",
                                                                                                   replacement = "_page"))

                output <-
                        output %>%
                        dplyr::left_join(output_b,  by = "rowid") %>%
                        dplyr::select(-rowid)

                output %>%
                        dplyr::mutate(issues_page_url = paste0("https://github.com/", github_user, "/", name, "/issues")) %>%
                        dplyr::mutate(pages_url = NA) %>%
                        dplyr::mutate(pages_url = ifelse(has_pages == "TRUE",
                                                         paste0("https://", github_user, ".github.io/", name, "/"),
                                                         pages_url)) %>%
                        dplyr::select(name, full_name, pages_url, html_url, clone_url, issues_page_url, homepage, url, dplyr::everything()) %>%
                        tibble::as_tibble()

        }


#' @title
#' Get Information about GitHub Repository
#'
#' @description
#' Filter the output of `get_repos()` for a specific repository by name.
#'
#' @inheritParams get_repos
#' @param repo          Repository name as a string (case insensitive).
#' @param as_list       If TRUE, the repository information is returned as a list object instead of a single row tibble.
#'
#' @return
#' A tibble or if `as_list` is set to `TRUE`, a list object.
#'
#' @rdname get_repo_info
#' @export
#' @importFrom dplyr filter

get_repo_info <-
        function(github_user,
                 repo,
                 as_list = FALSE) {

                output <-
                        get_repos(github_user = github_user) %>%
                        dplyr::filter(tolower(name) %in% tolower(repo))

                if (as_list) {

                        as.list(output)

                } else {

                        output

                }
        }



browse_issues <-
        function(github_user,
                 repo,
                 issue_no = NULL) {

                if (is.null(issue_no)) {

                        issues_page_url <- sprintf("https://github.com/%s/%s/issues",
                                                                        github_user,
                                                                        repo)

                } else {


                        issues_page_url <- sprintf("https://github.com/%s/%s/issues/%s",
                                                   github_user,
                                                   repo,
                                                   issue_no)

                }

                browseURL(issues_page_url)

        }

# html_url main GitHub Page
# issues_page_url Issues Page
# events_url JSON of pushes and pulls etc...
# deployments_url JSON of deployment history
# branches_page JSON of all branches
# commits_page JSON of all commits
#
