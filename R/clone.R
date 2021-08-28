#' @title Clone a Git Repository
#'
#' @param destination_path      Path of the destination directory to which the repo will be cloned.
#' @return
#' Cloned repo in the path of {destination_path/repo name} if the directory does not exist. Otherwise an error is thrown.
#'
#' @export
#' @importFrom cave strip_fn
#' @importFrom magrittr %>%
#' @importFrom purrr map
clone <-
  function(github_user, repo, destination_path) {
    clone_url <- sprintf("https://github.com/%s/%s.git", github_user, repo)

    local_repo_path <-
      basename(clone_url) %>%
      stringr::str_replace_all(
        pattern = "(^.*)([.]{1}[a-zA-Z]{1,}$)",
        replacement = "\\1"
      ) %>%
      purrr::map(~ paste0(destination_path, "/", .)) %>%
      unlist()

    if (!dir.exists(local_repo_path)) {
      command <-
        sprintf(
          "cd\n
                                cd %s\n
                                git clone %s\n",
          destination_path,
          clone_url
        )



      system(command = command)

      invisible(local_repo_path)
    } else {
      stop(local_repo_path, " already exists")
    }
  }
