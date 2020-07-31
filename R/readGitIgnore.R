#' Read .gitignore
#' @description This function reads the .gitignore file in the repo. If one is not present, it is created.
#' @importFrom readr read_lines
#' @export


readGitIgnore <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                gitignore_path <- paste0(path_to_local_repo, "/.gitignore")

                if (file.exists(gitignore_path)) {

                                readr::read_lines(file = gitignore_path)

                } else {

                                file.create(gitignore_path)
                                cat(".Rproj.user",
                                    ".Rhistory",
                                    ".RData",
                                    ".Ruserdata",
                                    sep = "\n",
                                    file = gitignore_path,
                                    append = TRUE)

                                readr::read_lines(file = gitignore_path)

                }

        }
