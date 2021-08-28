#' @title
#' Add Files
#' @seealso
#'  \code{\link[cli]{cat_line}}
#'  \code{\link[secretary]{character(0)}},\code{\link[secretary]{press_enter}}
#'  \code{\link[rlang]{list2}}
#'  \code{\link[purrr]{map}}
#' @rdname add
#' @export
#' @importFrom cli cat_line cat_rule cat_bullet
#' @importFrom secretary magentaTxt press_enter
#' @importFrom rlang list2
#' @importFrom purrr map
#' @importFrom magrittr %>%
add <-
  function(...,
           path = getwd(),
           pattern = NULL,
           all.files = FALSE,
           recursive = FALSE,
           ignore.case = FALSE,
           include.dirs = FALSE,
           no.. = FALSE,
           max_mb = 50) {
    path <- normalizePath(path.expand(path = path), mustWork = TRUE)
    path_to_root <- root(path = path)

    cli::cat_line()
    status(path = path)


    if (!missing(...)) {
      files_to_add <- rlang::list2(...)
      files_to_add <- file.path(path, unlist(files_to_add))
    } else {
      files_to_add <-
        list.files(
          path = path,
          pattern = pattern,
          all.files = all.files,
          full.names = TRUE,
          recursive = recursive,
          ignore.case = ignore.case,
          include.dirs = include.dirs,
          no.. = no..
        )
    }

    big_files <- list_big_files(mb_threshold = max_mb, path = path_to_root)
    files_to_add_big <- big_files[big_files %in% files_to_add]

    if (length(files_to_add_big) > 0) {
      cli::cat_rule(secretary::magentaTxt(sprintf("Files Greater Than %s MB", max_mb)))
      cli::cat_bullet(big_files,
        bullet = "line"
      )

      cli::cli_alert(text = "No files are added.")
    } else {
      if (missing(...) && is.null(pattern)) {
        command <-
          c(
            starting_command(path = path_to_root),
            "git add ."
          ) %>%
          paste(collapse = "\n")
      } else {
        command <-
          c(
            sprintf("cd\ncd %s\n", path_to_root),
            files_to_add %>%
              purrr::map(~ sprintf("git add %s", .)) %>%
              unlist()
          ) %>%
          paste(collapse = "\n")
      }



      system(command = command)


      status(
        path = path,
        header = "Updated Status Response"
      )
    }
  }
