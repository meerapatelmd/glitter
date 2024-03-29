#' @title
#' Add and Commit
#' @rdname ac
#' @export
ac <-
  function(commit_msg,
           ...,
           path = getwd(),
           pattern = NULL,
           all.files = FALSE,
           recursive = FALSE,
           ignore.case = FALSE,
           include.dirs = FALSE,
           no.. = FALSE,
           max_mb = 50,
           verbose = TRUE) {
    stopifnot(!missing(commit_msg))

    add(
      ...,
      path = path,
      pattern = pattern,
      all.files = all.files,
      recursive = recursive,
      ignore.case = ignore.case,
      include.dirs = include.dirs,
      no.. = no..,
      max_mb = max_mb
    )

    commit(
      commit_msg = commit_msg,
      path = path,
      verbose = verbose
    )
  }
