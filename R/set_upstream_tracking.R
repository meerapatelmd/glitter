#' @export
set_upstream_tracking <-
  function(path = getwd(),
           remote = "origin",
           branch = "master",
           local_branch = "master") {
    command <-
      sprintf(
        "cd\n
                        cd %s\n
                        git branch --set-upstream-to=%s/%s %s\n",
        path,
        remote,
        branch,
        local_branch
      )

    system(command = command)
  }
