#' @title
#' Recover Files that Have Been Deleted
#'
#' @name recover
NULL


#' @export


list_all_deleted_files <-
  function(path = getwd(),
           verbose = TRUE) {
    command <- sprintf("cd\ncd %s\ngit log --diff-filter=D --summary | grep delete", path)


    resp <-
      system(command,
        intern = TRUE
      )

    if (verbose) {
      printMsg(resp)
    }

    output <- stringr::str_replace_all(
      string = resp,
      pattern = "(^.*[ ]{1})([^ ]{1,}.*$)",
      replacement = "\\2"
    )
    output <- file.path(path, output)

    invisible(output)
  }


#' Recover a Lost File
#' @export

recover_lost_file <-
  function(sha = NULL,
           file,
           verbose = TRUE,
           path = getwd()) {
    file <- path.expand(file)

    if (is.null(sha)) {
      sha <-
        last_file_commit(
          file = file,
          path = path
        )
    }

    checkoutResponse <-
      system(paste0("cd\ncd ", path, "\ngit checkout ", sha, "^ -- ", file),
        intern = TRUE
      )

    if (verbose) {
      printMsg(checkoutResponse)
    }

    invisible(checkoutResponse)
  }
