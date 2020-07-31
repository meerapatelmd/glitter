#' Add .gitignore
#' @description This function adds an entry to the .gitignore file in the repo. If one is not present, it is created.
#' @importFrom readr read_lines
#' @importFrom rlang list2
#' @importFrom magrittr %>%
#' @export


addToGitIgnore <-
        function(...,
                 commit = TRUE,
                 path_to_local_repo = NULL) {

                if (missing(...)) {

                        stop("no input")

                }


                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                additions <- rlang::list2(...) %>%
                                        unlist()

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                gitignore_path <- paste0(path_to_local_repo, "/.gitignore")

                if (!file.exists(gitignore_path)) {

                                file.create(gitignore_path)

                                cat(".Rproj.user",
                                  ".Rhistory",
                                  ".RData",
                                  ".Ruserdata",
                                  additions,
                                  file = gitignore_path,
                                  sep = "\n",
                                  append = FALSE)

                } else {

                        cat(additions,
                            file = gitignore_path,
                            sep = "\n",
                            append = TRUE)

                }

                dedupeGitIgnore(path_to_local_repo = path_to_local_repo,
                                commit = FALSE)

                if (commit) {

                                if (".gitignore" %in% lsUnstagedFiles(path_to_local_repo = path_to_local_repo)) {

                                                add_file(file = ".gitignore",
                                                         path_to_local_repo = path_to_local_repo)


                                                if (".gitignore" %in% lsStagedFiles(path_to_local_repo = path_to_local_repo)) {


                                                                commitMessage <- commit(path_to_local_repo = path_to_local_repo,
                                                                       commit_message = paste0("add ", paste(additions, collapse = ", "), " to .gitignore"),
                                                                       verbose = FALSE)


                                                                printMsg(commitMessage)


                                                }

                                }

                }

        }
