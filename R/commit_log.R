#' @title
#' See Commit Log
#'
#' @description
#' See the history of all the commits that have been made in the console. The history is also parsed and invisibly returned as a dataframe with `sha` and `commit_msg` fields.
#'
#' @rdname commit_log
#' @export

commit_log <-
  function(path = getwd(),
           verbose = TRUE,
           remove = TRUE) {
    log_response <- system(paste0("cd\n", "cd ", path, "\n git log --oneline --graph --all"), intern = TRUE)

    if (verbose) {
      printMsg(log_response)
    }


    log_response_df <-
      tibble::tibble(log_response = log_response) %>%
      tidyr::extract(
        col = log_response,
        into = c("garbage", "sha", "commit_msg"),
        regex = "(^[*] )([a-zA-Z0-9]{7})(.*$)",
        remove = remove
      ) %>%
      dplyr::select(-garbage) %>%
      dplyr::mutate_all(as.character) %>%
      dplyr::mutate_all(trimws) %>%
      dplyr::filter_all(dplyr::all_vars(!is.na(.)))

    invisible(log_response_df)
  }
