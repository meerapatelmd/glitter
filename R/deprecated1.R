#' See the history of your commits in a graph
#' @export

commitHistoryGraph <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                .Deprecated("commit_graph")

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                logResponse <- system(paste0("cd\n", "cd ", path_to_local_repo, "\n git log --oneline --graph --all"), intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }





#' List Files To Commit
#' @description This function combines all the Unstaged and Untracked files in a repo.
#' @export


lsFilesToCommit <-
        function(path_to_local_repo = NULL,
                 label = FALSE) {

                c(lsUnstagedFiles(path_to_local_repo = path_to_local_repo,
                                  label = label),
                  lsUntrackedFiles(path_to_local_repo = path_to_local_repo))

        }





#' List Staged Files
#' @description
#' This function lists all the staged files in a local repo.
#' @return
#' If staged files exist, a vector of all the staged file paths.
#' @param modified      PARAM_DESCRIPTION, Default: TRUE
#' @param deleted       PARAM_DESCRIPTION, Default: TRUE
#' @param new_file      PARAM_DESCRIPTION, Default: TRUE
#' @param renamed       PARAM_DESCRIPTION, Default: TRUE
#' @param label         If TRUE, returns the results with prefix of "modified:|deleted:|new file: {file path}"
#' @seealso
#'  \code{\link[purrr]{keep}},\code{\link[purrr]{map}}
#'  \code{\link[stringr]{str_replace}}
#'  \code{\link[secretary]{typewrite}}
#' @rdname lsStagedFiles
#' @export
#' @importFrom magrittr %>%
#' @importFrom purrr keep map
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite

lsStagedFiles <-
        function(path_to_local_repo = NULL,
                 modified = TRUE,
                 deleted = TRUE,
                 new_file = TRUE,
                 renamed = TRUE,
                 label = FALSE) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }


                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Changes to be committed:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage <-
                        parsedStatusMessage$`Changes to be committed:` %>%
                                                trimws(which = "both") %>%
                                                sort()


                        output <-
                        c(
                        parsedStatusMessage %>%
                                purrr::keep(~((modified == TRUE) & grepl("modified[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((deleted == TRUE) & grepl("deleted[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((new_file == TRUE) & grepl("new file[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((renamed == TRUE) & grepl("renamed[:]", .))) %>%
                                purrr::map(~stringr::str_replace_all(., "(^.*?[-]{1}[>]{1} )(.*$)", "\\2")))

                        if (label) {
                                return(output)
                        } else {
                                stringr::str_replace_all(output,
                                                         "(^.*?[:]{1})([ ]{1,})(.*$)",
                                                         "\\3")
                        }



                } else {

                        secretary::typewrite("No staged files in", path_to_local_repo)

                }
        }





#' List Unstaged Files
#' @description This function lists all the unstaged files in a local repo.
#' @return If unstaged files exist, a vector of all the untracked file paths.
#' @seealso
#'  \code{\link[purrr]{keep}}
#'  \code{\link[stringr]{str_replace}}
#'  \code{\link[secretary]{typewrite}}
#' @rdname lsUnstagedFiles
#' @export
#' @importFrom magrittr %>%
#' @importFrom purrr keep
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite

lsUnstagedFiles <-
        function(path_to_local_repo = NULL,
                 modified = TRUE,
                 deleted = TRUE,
                 label = FALSE) {

                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Changes not staged for commit:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage <-
                        parsedStatusMessage$`Changes not staged for commit:` %>%
                                                trimws(which = "both") %>%
                                                sort()

                        output <-
                        c(
                        parsedStatusMessage %>%
                                purrr::keep(~((modified == TRUE) & grepl("modified[:]", .))),
                        parsedStatusMessage %>%
                                purrr::keep(~((deleted == TRUE) & grepl("deleted[:]", .))))

                        if (label) {
                                return(output)
                        } else {
                                stringr::str_replace_all(output,
                                                         "(^.*?[:]{1})([ ]{1,})(.*$)",
                                                         "\\3")
                        }

                } else {

                        secretary::typewrite("No unstaged files in", path_to_local_repo)

                }
        }





#' List Untracked Files
#' @description This function lists all the untracked files in a local repo.
#' @return If untracked files exist, a vector of all the untracked file paths.
#' @export
#' @importFrom magrittr %>%
#' @importFrom secretary typewrite


lsUntrackedFiles <-
        function(path_to_local_repo = NULL) {

                statusMessage <- status(path_to_local_repo = path_to_local_repo,
                                        verbose = FALSE)

                parsedStatusMessage <- parseStatusMessage(statusMessage = statusMessage)

                if ("Untracked files:" %in% names(parsedStatusMessage)) {

                        parsedStatusMessage$`Untracked files:` %>%
                                                trimws(which = "both")

                } else {

                        secretary::typewrite("No untracked files in", path_to_local_repo)

                }
        }










#' Add All Files to a Commit
#' @param path_to_local_repo Full path to local repository. If NULL, adds all the files
#' @importFrom secretary typewrite_error
#' @importFrom magrittr %>%
#' @importFrom cave size_in_mb
#' @import dplyr
#' @import rubix
#' @import purrr
#' @export


add_all <-
        function(path_to_local_repo = NULL) {
                        require(tidyverse)

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                        }

                        stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                        stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                        large_files <-
                        list.files(path_to_local_repo, full.names = TRUE) %>%
                                rubix::map_names_set(cave::size_in_mb) %>%
                                purrr::keep(function(x) x > 100) %>%
                                names()

                        if (length(large_files) > 0) {


                                stop("Files greater than 100 MB found: ", paste(large_files, collapse = ", "))

                        }

                        system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git add ."),
                                       intern = FALSE)

        }





#' @title Add and Commit All Files
#' @description
#' This function adds all the deltas in the working directory to a commit. The commit occurs on the condition that the git status response does not indicate that the working tree is clean.
#'
#' @param path_to_local_repo    full path to local repository where the add and commit all will be performed
#' @param commit_message        If NULL, automatically creates a message in the format of "add/modify {filename} as written in {R script path}"
#' @param description           additional optional description
#' @param verbose               If TRUE, the function prints back the commit response message, Default: TRUE
#' @rdname add_commit_all
#' @export


add_commit_all <-
        function(
                 commit_message,
                 description = NULL,
                 verbose = TRUE,
                 path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                add_all(path_to_local_repo = path_to_local_repo)


                if (!isWorkingTreeClean(path_to_local_repo = path_to_local_repo)) {


                        commit(path_to_local_repo = path_to_local_repo,
                               commit_message = commit_message,
                               description = description,
                               verbose = verbose
                        )


                }

        }






#' Add and Commit Some Files
#' @param path_to_local_repo full path to local repository to be pushed
#' @param filenames names of files in the local repository path to be committed
#' @param commit_message defaults to NULL, where the commit_message is a "change to {filename} in {path to present R script}"
#' @export


add_commit_some <-
        function(
                 filenames,
                 commit_message = NULL,
                 description = NULL,
                 verbose = TRUE,
                 path_to_local_repo = NULL) {

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()

                        }

                        add_some(path_to_local_repo = path_to_local_repo,
                                                                filenames = filenames)


                        commit(path_to_local_repo = path_to_local_repo,
                               commit_message = commit_message,
                               description = description,
                               verbose = verbose
                        )
        }





#' Add an Entry to .gitignore
#' @description This function adds an entry to the .gitignore file in the repo. If one is not present, it is created.
#' @importFrom readr read_lines
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

                additions <- list(...) %>% unlist()

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










#' Browse a Package's GitHub Page
#' @export


browseGitHubPages <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }
                #Installing package by first getting URL of the remote
                git_url <- remote_url(path_to_local_repo = path_to_local_repo)

                #Installing it as either a public or an Enterprise GitHub repo
                if (grepl("github.com/patelm9", git_url, ignore.case = TRUE) == TRUE) {
                        browseURL(url = paste0("https://patelm9.github.io/", basename(path_to_local_repo), "/index.html"))
                }
        }










#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param commit_msg PARAM_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: NULL
#' @param verbose PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[secretary]{typewrite_bold}},\code{\link[secretary]{character(0)}},\code{\link[secretary]{typewrite_italic}}
#' @rdname com
#' @export
#' @importFrom secretary typewrite_bold yellowTxt typewrite_italic redTxt

com <-
        function(commit_msg,
                 path = getwd(),
                 verbose = TRUE) {


                command <-
                        c(starting_command(path = path),
                          paste0("git commit -m '", commit_msg, "'")) %>%
                        paste(collapse = "\n")

                commit_response <-
                        suppressWarnings(
                                system(command = command,
                                       intern = TRUE))

                if (verbose) {

                        cli::cat_line()
                        cli::cat_rule(secretary::yellowTxt("Commit Response"))

                        if ("no changes added to commit" %in% commit_response) {
                                secretary::typewrite_italic(secretary::redTxt("\tNo changes added to the commit."))
                        }

                        cat(paste0("\t\t", commit_response), sep = "\n")

                        cli::cat_line()
                }

                invisible(commit_response)
        }










