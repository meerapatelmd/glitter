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
                                list.files(path = path,
                                           pattern = pattern,
                                           all.files = all.files,
                                           full.names = TRUE,
                                           recursive = recursive,
                                           ignore.case = ignore.case,
                                           include.dirs = include.dirs,
                                           no.. = no..)

                }

                big_files <- list_big_files(mb_threshold = max_mb, path = path_to_root)
                files_to_add_big <- big_files[big_files %in% files_to_add]

                if (length(files_to_add_big) > 0) {

                        cli::cat_rule(secretary::magentaTxt(sprintf("Files Greater Than %s MB", max_mb)))
                        cli::cat_bullet(big_files,
                                        bullet = "line")

                        cli::cli_alert(text = "No files are added.")

                } else {

                        if (missing(...) && is.null(pattern)) {

                                command <-
                                        c(starting_command(path = path_to_root),
                                          "git add .") %>%
                                        paste(collapse = "\n")


                        } else {

                        command <-
                                c(starting_command(path = path_to_root),
                                  files_to_add %>%
                                          purrr::map(~ sprintf("git add %s", .)) %>%
                                          unlist()) %>%
                                        paste(collapse = "\n")

                        }



                        system(command = command)


                        status(path = path,
                               header = "Updated Status Response")

                }

        }





#' @title
#' Commit
#' @rdname commit
#' @export

commit <-
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










#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[secretary]{typewrite_warning}}
#' @rdname root
#' @export
#' @importFrom secretary typewrite_warning
#' @importFrom magrittr %>%


root <-
        function(path = getwd()) {

                path <- normalizePath(path.expand(path = path), mustWork = TRUE)

                if (!(file.info(path)$isdir)) {
                        path <- dirname(path)
                }



                command <-
                        c("cd",
                          paste0("cd ", path),
                          "git rev-parse --show-toplevel")

                command <- paste(command, collapse = "\n")

                output <-
                        system(command = command,
                               intern = FALSE,
                               ignore.stdout = TRUE,
                               ignore.stderr = TRUE)

                if (output == 0) {

                        system(command = command,
                               intern = TRUE)

                }

        }






#' Pull a Remote Repo
#' @param path full path to directory of the repo to be pulled
#' @export

pull <-
        function(path = getwd(),
                 verbose = TRUE) {



                command <-
                        c(starting_command(path = path),
                          "git pull") %>%
                        paste(collapse = "\n")

                pull_response <-
                        system(command = command,
                               intern = TRUE)

                if (verbose) {
                        cat("\n")
                        secretary::typewrite_bold(secretary::magentaTxt("\tPull Response:"))
                        cat(paste0("\t\t", pull_response), sep = "\n")
                        cat("\n")
                }

                invisible(pull_response)

        }











#' Push a local repo to a GitHub repository
#' @param path full path to local repository to be pushed
#' @param remote_name name of remote to push to. Defaults to "origin".
#' @param remote_branch name of branch on the remote to push to. Defaults to "master".
#' @export


push <-
        function(remote_name = "origin",
                 remote_branch = "master",
                 path = getwd(),
                 verbose = TRUE) {




                status_response <- status(path = path,
                                          verbose = FALSE)

                #if (any(grepl('use "git push" to publish your local commits', status_response))) {

                        command <-
                                c(starting_command(path = path),
                                  paste0("git push ", remote_name, " ", remote_branch)) %>%
                                paste(collapse = "\n")

                        system(command = command,
                               intern = FALSE)

                #}

        }










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
                                stringr::str_replace_all(pattern = "(^.*)([.]{1}[a-zA-Z]{1,}$)",
                                                         replacement = "\\1") %>%
                                purrr::map(~paste0(destination_path, "/", .)) %>%
                                unlist()

                if (!dir.exists(local_repo_path)) {
                        command <-
                        sprintf(
                                "cd\n
                                cd %s\n
                                git clone %s\n"
                                ,
                                destination_path,
                                clone_url)



                                system(command = command)



                } else {

                                stop(local_repo_path, " already exists")

                }
        }



#' Get a list of modified files in a repo
#' @description This function takes the git status message and isolates the files that have been modified according to that message.
#' @return The complete git status message and modified files are printed in the console, and a vector of the modified filenames is invisibly returned.
#' @param path path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

list_modified_files <-
        function(path) {
                .Deprecated(new = "lsStagedFiles")
                secretary::typewrite_bold("Git Status:", line_number = 0, add_to_readme = FALSE)

                status_msg <- status(path = path)
                modified_status <- grep("^\tmodified:", status_msg, value = TRUE)

                fns <- vector()
                while (length(modified_status) > 0) {
                        modified_file <- modified_status[1]
                        fn <- stringr::str_replace_all(modified_file,
                                                       pattern = "(^\tmodified:[ ]*)([^ ]{1}.*$)",
                                                       "\\2")

                        fns <- c(fns, fn)
                        modified_status <- modified_status[-1]
                }

                if (length(fns) > 0) {
                        secretary::typewrite_bold("\nModified Files:", line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(fns)
                        invisible(fns)
                } else {
                        invisible(NULL)
                        secretary::typewrite_italic("No modified files in this repo.\n")
                }
        }



#' @title
#' Add and Commit
#' @rdname ac
#' @export

ac <-
        function(commit_msg,
                 ...,
                 path = getwd(),
                 pattern = NULL,
                 all.files = FALSE,
                 recursive = FALSE,
                 ignore.case = FALSE,
                 include.dirs = FALSE,
                 no.. = FALSE,
                 max_mb = 50,
                 verbose = TRUE)

        {

                stopifnot(!missing(commit_msg))

                add(
                        ...,
                        path = path,
                        pattern = pattern,
                        all.files = all.files,
                        recursive = recursive,
                        ignore.case = ignore.case,
                        include.dirs = include.dirs,
                        no.. = no..,
                        max_mb = max_mb
                )

                commit(commit_msg = commit_msg,
                       path = path,
                       verbose = verbose)


        }



#' @title
#' Add, Commit, and Push
#'
#' @rdname acp
#' @export

acp <-
        function(commit_msg,
                 ...,
                 path = getwd(),
                 pattern = NULL,
                 all.files = FALSE,
                 recursive = FALSE,
                 ignore.case = FALSE,
                 include.dirs = FALSE,
                 no.. = FALSE,
                 max_mb = 50,
                 remote_name = "origin",
                 remote_branch = "master",
                 verbose = TRUE) {

                ac(commit_msg = commit_msg,
                   path = path,
                   pattern = pattern,
                   all.files = all.files,
                   recursive = recursive,
                   ignore.case = ignore.case,
                   include.dirs = include.dirs,
                   no.. = no..,
                   max_mb = max_mb,
                   verbose = verbose)

                push(remote_name = remote_name,
                     remote_branch = remote_branch,
                     path = path,
                     verbose = verbose)
        }

#' @title
#' Add and commit .gitignore
#' @export

ac_gitignore <-
        function(path = getwd()) {

                path_to_root <- root(path = path)

                ac(".gitignore",
                    path = path_to_root,
                    commit_msg = "update .gitignore")
        }


#' @title Get the Git status of any local repo using the path
#' @return
#' If the git message is of a length greater than 0, it is returned as a character vector and also printed in the console
#' @param path full path to local repository to be pushed
#' @export


status <-
        function(path = getwd(),
                 verbose = TRUE,
                 header = "Status Response") {

                        command <-
                                c(starting_command(path = path),
                                  "git status") %>%
                                paste(collapse = "\n")

                        status_response <-
                                system(command = command,
                                       intern = TRUE)

                        if (verbose) {
                                cli::cat_line()
                                cli::cat_rule(secretary::greenTxt(header))
                                cat(paste0("\t\t", status_response), sep = "\n")
                                cli::cat_line()
                        }

                        invisible(status_response)

        }










#' Get Git Remote URL
#' @param remote_name Name of the remote. Defaults to "Origin".
#' @return url of the remote as a string
#' @export

remote_url <-
        function(path = NULL,
                 remote_name = "origin") {

                if (is.null(path)) {

                        path <- getwd()

                }

                suppressWarnings(
                system(paste0("cd\n",
                              "cd ", path,"\n",
                              "git remote get-url ", remote_name),
                       ignore.stderr = TRUE,
                       intern = TRUE)
                )
        }

#' Git Log
#' @export

log <-
        function(repo_path = NULL,
                 verbose = TRUE) {

                if (is.null(repo_path)) {
                        repo_path <- getwd()
                }

                logResponse <-
                        system(
                                paste0("cd\ncd ", repo_path,"\n", "git log"),
                                intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }



#' @export

set_upstream_tracking <-
        function(path = getwd(),
                 remote = "origin",
                 branch = "master",
                 local_branch = "master") {


                command <-
                sprintf("cd\n
                        cd %s\n
                        git branch --set-upstream-to=%s/%s %s\n",
                                path,
                                remote,
                                branch,
                                local_branch)

                system(command = command)
        }
