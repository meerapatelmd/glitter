#' @title
#' Add, Commit, and Push
#'
#' @rdname acp
#' @export
acp <-
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
           remote_name = "origin",
           remote_branch = "master",
           verbose = TRUE) {
    ac(
      commit_msg = commit_msg,
      path = path,
      pattern = pattern,
      all.files = all.files,
      recursive = recursive,
      ignore.case = ignore.case,
      include.dirs = include.dirs,
      no.. = no..,
      max_mb = max_mb,
      verbose = verbose
    )

    push(
      remote_name = remote_name,
      remote_branch = remote_branch,
      path = path,
      verbose = verbose
    )
  }
