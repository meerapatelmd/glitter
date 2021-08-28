#' @title
#' Git Root
#' @seealso
#'  \code{\link[secretary]{typewrite_warning}}
#' @rdname root
#' @export
#' @importFrom secretary typewrite_warning
#' @importFrom magrittr %>%
root <-
  function(path = getwd()) {
    path <- normalizePath(path.expand(path = path), mustWork = TRUE)

    if (!(file.info(path)$isdir)) {
      path <- dirname(path)
    }



    command <-
      c(
        "cd",
        paste0("cd ", path),
        "git rev-parse --show-toplevel"
      )

    command <- paste(command, collapse = "\n")

    output <-
      system(
        command = command,
        intern = FALSE,
        ignore.stdout = TRUE,
        ignore.stderr = TRUE
      )

    if (output == 0) {
      system(
        command = command,
        intern = TRUE
      )
    }
  }
