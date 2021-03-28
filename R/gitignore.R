#' @export

gi_readlines <-
  function(path = getwd()) {
    gi_path <- sprintf("%s/.gitignore", path)

    readLines(con = gi_path)
  }

#' @export

gi_add <-
  function(...,
           path = getwd()) {
    Args <- unlist(list(...))

    gi_path <- sprintf("%s/.gitignore", path)

    cat(Args,
      sep = "\n",
      file = gi_path,
      append = TRUE
    )
  }


#' @export

gi_rm <-
  function(...,
           path = getwd()) {
    Args <- unlist(list(...))

    gitignore_values <- gi_readlines(path = path)


    gitignore_values <- gitignore_values[!(gitignore_values %in% Args)]

    gi_path <- sprintf("%s/.gitignore", path)
    cat(gitignore_values,
      sep = "\n",
      file = gi_path,
      append = FALSE
    )
  }
