#' Remove from .gitignore
#' @description This function remoes an entry in a .gitignore file if there is one in the repo path.
#' @importFrom readr read_lines
#' @importFrom rlang list2
#' @importFrom magrittr %>%
#' @export


rmFromGitIgnore <-
        function(...,
                 commit = TRUE,
                 path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                gitignore_path <- paste0(path_to_local_repo, "/.gitignore")

                remove <- rlang::list2(...) %>%
                                        unlist()

                if (file.exists(gitignore_path)) {

                        gitignore <- readGitIgnore(path_to_local_repo = path_to_local_repo) %>%
                                                unique()

                        gitignore <- gitignore[!(gitignore %in% remove)]

                        cat(gitignore,
                            file = gitignore_path,
                            sep = "\n")

                        dedupeGitIgnore(path_to_local_repo = path_to_local_repo,
                                        commit = FALSE)

                        if (commit) {

                                if (".gitignore" %in% lsUntrackedFiles(path_to_local_repo = path_to_local_repo)) {
                                        add_file(path_to_local_repo = path_to_local_repo,
                                                 file = ".gitignore")

                                        if (".gitignore" %in% lsStagedFiles(path_to_local_repo = path_to_local_repo)) {
                                                commitResponse <-
                                                commit(path_to_local_repo = path_to_local_repo,
                                                       commit_message = paste0("remove ", paste(remove, collapse = ", "), " from .gitignore"),
                                                       verbose = FALSE)

                                                printMsg(commitResponse)


                                        }
                                }

                        }
                }

        }
