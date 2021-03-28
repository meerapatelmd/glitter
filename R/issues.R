#' @title List Open GitHub Issues
#' @description
#' All GitHub Issues functions in this package requires downloading and setting up authorization for \href{https://github.com/stephencelis/ghi}{GHI}.
#' @param path path to the local path targeted by the function call. If NULL, the function is executed on the working directory
#' @return The system command stdout is printed in the R console and a dataframe from that same data is returned invisibly.
#' @details DETAILS
#' @seealso
#'  \code{\link[tibble]{tibble}}
#'  \code{\link[rubix]{filter_at_grepl}}
#'  \code{\link[tidyr]{extract}}
#'  \code{\link[dplyr]{filter}}
#' @rdname list_open_issues
#' @importFrom tibble tibble
#' @importFrom rubix filter_at_grepl
#' @importFrom tidyr extract
#' @importFrom dplyr filter
#' @importFrom magrittr %>%
#' @export

list_open_issues <-
  function(path = getwd()) {
    system(paste0(
      "cd\n",
      "cd ", path, "\n",
      "/usr/local/bin/ghi list"
    ),
    intern = FALSE
    )


    output <-
      # Converting the vector of issues into a dataframe
      tibble::tibble(Issues = system(paste0(
        "cd\n",
        "cd ", path, "\n",
        "/usr/local/bin/ghi list"
      ),
      intern = TRUE
      )) %>%
      # Removing theheader to isolate the issue number and issue name
      rubix::filter_at_grepl(Issues,
        grepl_phrase = "[#]{1}.*open issues$",
        evaluates_to = FALSE
      ) %>%
      tidyr::extract(
        col = Issues,
        into = c(
          "issue_number",
          "OpenIssue"
        ),
        regex = "^[ ]+?([0-9]+?)[ ]+?([^ ]{1}.*$)"
      ) %>%
      # Filter out all NA
      dplyr::filter(!is.na(issue_number))

    invisible(output)
  }

#' List Closed Issues
#' @export
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom tidyr extract
#' @importFrom dplyr mutate_all
#' @rdname list_closed_issues

list_closed_issues <-
  function(path = getwd()) {
    system(paste0(
      "cd\n",
      "cd ", path, "\n",
      "ghi close --list"
    ),
    intern = FALSE
    )


    output <-
      tibble::tibble(Issues = system(paste0(
        "cd\n",
        "cd ", path, "\n",
        "ghi close --list"
      ),
      intern = TRUE
      )[-1]) %>%
      tidyr::extract(
        col = Issues,
        into = c(
          "issue_number",
          "ClosedIssue"
        ),
        regex = "(^[ ]{0,}[0-9]{1,}[ ]*?)([a-zA-Z]{1,}.*$)"
      ) %>%
      dplyr::mutate_all(trimws, "both")

    invisible(output)
  }


#' Open a GitHub Issue
#' @description This function opens a GitHub Issue from the R console.
#' @export
#' @rdname open_issue

open_issue <-
  function(title,
           description,
           path = getwd()) {
    prompt <-
      paste0(
        "cd\n",
        "cd ", path, "\n",
        "ghi open -m '", description, "' \ '", title, "'"
      )

    system(prompt)
  }


#' Close a GitHub Issue
#' @description This function closes a GitHub Issue from the R console.
#' @export
#' @rdname close_issue

close_issue <-
  function(issue_number,
           issue_message,
           path = getwd()) {
    prompt <-
      paste0(
        "cd\n",
        "cd ", path, "\n",
        "ghi close -m '", issue_message, "' \ '", issue_message, "' ", issue_number
      )

    system(prompt)
  }


#' Show a GitHub Issue
#' @description This function shows a GitHub Issue from the R console.
#' @export
#' @rdname show_issue

show_issue <-
  function(issue_number,
           path = getwd()) {
    prompt <-
      paste0(
        "cd\n",
        "cd ", path, "\n",
        "ghi show ", issue_number
      )

    system(prompt)
  }
