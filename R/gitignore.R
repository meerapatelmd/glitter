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

                cat(Args, sep = "\n",
                    file = gi_path,
                    append = TRUE)
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
                    append = FALSE)

        }



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





#' @title Remove lines from .gitignore
#' @description
#' This function removes an entry in a .gitignore file if there is one in the repo path.
#'
#' @param ...                   Lines to remove
#' @param commit                If TRUE, will commit changes to .gitignore, Default: TRUE
#' @param path_to_local_repo    Path to the local repository where the .gitignore file is located. If NULL, the function defers to using the current working directory, Default: NULL
#' @rdname rmFromGitIgnore
#' @export


rmFromGitIgnore <-
        function(...,
                 commit = TRUE,
                 path_to_local_repo = NULL) {

                .Deprecated("rm_gitignore")

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)

                gitignore_path <- paste0(path_to_local_repo, "/.gitignore")

                remove <- unlist(list(...))

                if (file.exists(gitignore_path)) {

                        gitignore <- unique(readGitIgnore(path_to_local_repo = path_to_local_repo))

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





