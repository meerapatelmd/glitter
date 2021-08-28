#' Push a local repo to a GitHub repository
#' @param path full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to
#' "origin".
#' @param remote_branch name of branch on the remote to push
#' to. Defaults to "master" or "main" if the cardinal branch is using
#' this newer default.
#' @export
#' @rdname push_tag
#' @importFrom magrittr %>%
#' @importFrom rlang list2
push_tag <-
  function(path = getwd(),
           remote_name = "origin",
           remote_branch = "master",
           verbose = TRUE,
           ...) {
    if (remote_branch == "master" && is_main(path = path)) {
      remote_branch <- "main"
    }




    status_response <- status(
      path = path,
      verbose = FALSE
    )

    command <-
      as.character(
      glue::glue(
        "cd",
        "cd {path}",
        "git push {remote_name} {remote_branch} --tag",
        .sep = "\n"))


    if (!missing(...)) {

      command <-
        c(command,
          glue::glue_collapse(unlist(rlang::list2(...)),
                              sep = " "))

    }

    print(command)

    system(
      command = command,
      intern = FALSE
    )

  }
