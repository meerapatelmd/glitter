#' @title
#' Add and commit .gitignore
#' @export
ac_gitignore <-
  function(path = getwd()) {
    path_to_root <- root(path = path)

    ac(".gitignore",
      path = path_to_root,
      commit_msg = "update .gitignore"
    )
  }
