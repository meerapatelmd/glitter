#' @title Git Diff
#' @description
#' Show unstaged changes between your index and working directory
#' @export


diff <-
  function(path = getwd()) {
    diffMessage <-
      system(paste0(
        "cd\n",
        "cd ", path, "\n",
        "git diff"
      ), intern = TRUE)

    printMsg(diffMessage)
  }
