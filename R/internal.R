#' @keywords internal
#' @export

clone_if_not_exist <-
  function(github_dir,
           ...) {
    stopifnot(!missing(...))

    remote_repos <- unlist(rlang::list2(...))

    local_repos <-
      cave::list.subdirs(
        dir = github_dir,
        full.names = TRUE,
        recursive = TRUE
      )

    uncloned_remote_repos <- remote_repos[!(remote_repos %in% basename(local_repos))]
    for (i in seq_along(uncloned_remote_repos)) {
      clone_url <-
        sprintf("https://github.com/meerapatelmd/%s.git", uncloned_remote_repos[i])
      clone(
        clone_url = clone_url,
        destination_path = github_dir
      )
    }
  }
