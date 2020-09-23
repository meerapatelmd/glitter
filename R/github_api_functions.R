#' @title
#' Make an API Call for a GitHub User's Remote Repositories
#' @description
#' This function makes an API call to the GitHub to retrieve all the repository information for a given GitHub User. All native fields in the JSON response are preserved with the additions "pages_url" and "issues_page_url" fields. The "pages_url" field is where a URL to the GitHub Pages for the repo is derived from the `name` field if the `has_pages` field is TRUE after the response is parsed into a dataframe. The same is done with the "issues_page_url" path except that no logic is applied since all GitHub repos will have an Issues page by default.
#'
#' @param github_username       GitHub username. Enterprise GitHub is not supported.
#'
#' @return
#' A list of length 2. List `SETTINGS` is a list of all the values in the parsed dataframe that remained constant in all rows such as all username-related (aka `owner`) fields. All other fields are maintained in the dataframe format and returned in `REPOS`.
#'
#' @seealso
#'  \code{\link[httr]{GET}},\code{\link[httr]{content}}
#'  \code{\link[purrr]{map}}
#'  \code{\link[dplyr]{bind}},\code{\link[dplyr]{mutate}},\code{\link[dplyr]{select}},\code{\link[dplyr]{reexports}},\code{\link[dplyr]{distinct}}
#'  \code{\link[rubix]{normalize_all_to_na}},\code{\link[rubix]{deselect_if_all_same}}
#' @rdname get_remote_repos
#' @family github api
#' @export
#' @importFrom httr GET content
#' @importFrom purrr map
#' @importFrom dplyr bind_rows mutate select everything distinct
#' @importFrom rubix normalize_all_to_na deselect_if_all_same


get_remote_repos <-
        function(github_username) {

                github_url <- paste0("https://api.github.com/users/", github_username, "/repos")

                resp <- httr::GET(github_url)

                output <-
                resp %>%
                        httr::content(type = "application/json", as = "parsed") %>%
                        purrr::map(unlist) %>%
                        purrr::map(as_tibble_row) %>%
                        dplyr::bind_rows() %>%
                        rubix::normalize_all_to_na() %>%
                        dplyr::mutate(issues_page_url = paste0("https://github.com/", github_username, "/", name, "/issues")) %>%
                        dplyr::mutate(pages_url = NA) %>%
                        dplyr::mutate(pages_url = ifelse(has_pages == "TRUE",
                                                         paste0("https://", github_username, ".github.io/", name, "/"),
                                                         pages_url)) %>%
                        dplyr::select(name, full_name, pages_url, html_url, clone_url, issues_page_url, homepage, url, dplyr::everything())


                output2b <-
                        output %>%
                                rubix::deselect_if_all_same()

                output2a <-
                        output %>%
                                dplyr::select(-colnames(output2b)) %>%
                        dplyr::distinct() %>%
                        unlist()

                list(SETTINGS = output2a,
                     REPOS = output2b)

        }


#' @title
#' Make an API Call to Get Repository Information
#'
#' @inherit get_remote_repos description
#' @inheritParams get_remote_repos
#'
#' @param repo          Repository belonging to the GitHub user
#' @param as_list       Return the repository information as a list object as opposed to a 1-row dataframe. This allows to easily view all the repository information in the R console, Default: FALSE
#'
#' @return
#' A dataframe or if `as_list` is set to `TRUE`, a list object.
#'
#' @seealso
#'  \code{\link[purrr]{pluck}}
#'  \code{\link[rubix]{filter_for}}
#' @rdname get_repo_info
#' @export
#' @importFrom purrr pluck
#' @importFrom rubix filter_for

get_repo_info <-
        function(github_username,
                 repo,
                 as_list = FALSE) {

                output <-
                        get_remote_repos(github_username = github_username) %>%
                        purrr::pluck("REPOS") %>%
                        rubix::filter_for(filter_col = name,
                                          inclusion_vector = repo)

                if (as_list) {
                        as.list(unlist(output))
                } else {
                        output
                }
        }
