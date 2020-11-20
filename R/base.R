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

                big_files <- list_big_files(mb_threshold = max_mb)
                if (length(big_files)) {

                        cli::cat_rule(secretary::magentaTxt(sprintf("Files Greater Than %s MB", max_mb)))
                        cli::cat_bullet(big_files,
                                        bullet = "line")

                        secretary::press_enter()

                }

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

                command <-
                        c(starting_command(path = path_to_root),
                          files_to_add %>%
                                  purrr::map(~ sprintf("git add %s", .)) %>%
                                  unlist()) %>%
                                paste(collapse = "\n")
                system(command = command)


                status(path = path,
                       header = "Updated Status Response")

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
#' @param remote_url            Web url of repository to clone
#' @param destination_path      Path of the destination directory to which the repo will be cloned.
#'
#' @return
#' Cloned repo in the path of {destination_path/repo name} if the directory does not exist. Otherwise an error is thrown.
#'
#' @export
#' @importFrom cave strip_fn
#' @importFrom magrittr %>%
#' @importFrom purrr map

clone <-
        function(remote_url, destination_path) {

                local_repo_path <-
                remote_url %>%
                        cave::strip_fn() %>%
                        purrr::map(~paste0(destination_path, "/", .)) %>%
                        unlist()

                if (!dir.exists(local_repo_path)) {

                                system(paste0("cd\n",
                                              "cd ", destination_path,"\n",
                                              "git clone ", remote_url, "\n"
                                              ))


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
        function(...,
                 path = getwd(),
                 pattern = NULL,
                 commit_msg,
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
#' Add and commit .gitignore
#' @export

ac_gitignore <-
        function(path = getwd()) {

                path_to_root <- root(path = path)

                ac(".gitignore",
                    path = path_to_root,
                    commit_msg = "update .gitignore")
        }
