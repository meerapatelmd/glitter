#' @title Remove duplicates from .gitignore
#' @description
#' This function reads the .gitignore file, removes duplicates, and overwrites the gitignore file.
#' @seealso
#'  \code{\link[readr]{read_lines}}
#' @rdname dedupeGitIgnore
#' @keywords internal
#' @export
#' @importFrom readr write_lines

dedupeGitIgnore <-
        function(commit = TRUE,
                 path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                input <- readGitIgnore(path_to_local_repo = path_to_local_repo)
                output <- unique(input)

                gitignore_path <- paste0(path_to_local_repo, "/.gitignore")

                readr::write_lines(output,
                                   path = gitignore_path)

                if (commit) {

                        commitMessage <-
                        add_commit_some(path_to_local_repo = path_to_local_repo,
                                        filenames = ".gitignore",
                                        commit_message = "dedupe .gitignore")

                        printMsg(commitMessage)
                }

        }
