#' Commit some, but not all files, in a local repo to remote GitHub repository
#' @param path_to_local_repo full path to local repository to be pushed
#' @param filenames names of files in the local repository path to be committed
#' @param commit_message defaults to NULL, where the commit_message is a "change to {filename} in {path to present R script}"
#' @importFrom secretary typewrite_error
#' @importFrom purrr keep
#' @importFrom rubix map_names_set
#' @importFrom crayon italic
#' @export


add_commit_some <-
        function(path_to_local_repo = NULL,
                 filenames,
                 commit_message = NULL,
                 description = NULL,
                 verbose = TRUE) {

                        add_some(path_to_local_repo = path_to_local_repo,
                                 filenames = filenames)

                        commit(path_to_local_repo = path_to_local_repo,
                               commit_message = commit_message,
                               description = description,
                               verbose = verbose
                        )

                #
                # if (dir.exists(path_to_local_repo)) {
                #
                #         input_filenames <- filenames
                #
                #         path_to_filenames <- paste0(path_to_local_repo, "/", filenames)
                #
                #
                #         ##Filtering for only files less than 100 MB
                        path_to_filenames <-
                        path_to_filenames %>%
                                rubix::map_names_set(cave::size_in_mb) %>%
                                purrr::keep(function(x) x < 100) %>%
                                names()
                #
                #         filenames <- basename(path_to_filenames)
                #
                #         if (length(filenames) > 0) {
                #
                #                         while (length(filenames) > 0) {
                #                                 fn <- filenames[1]
                #                                 fn <- sanitize_fns_for_cli(fn)
                #                                 x <- system(paste0("cd\n",
                #                                                    "cd ", path_to_local_repo,"\n",
                #                                                    "git add ", fn),
                #                                             intern = TRUE)
                #
                #                                 filenames <- filenames[-1]
                #                         }
                #
                #                         if (!is.null(commit_message)) {
                #                                 x <-
                #                                         commit(path_to_local_repo = path_to_local_repo,
                #                                                commit_message = commit_message,
                #                                                description = description)
                #
                #                         } else {
                #                                 x <-
                #                                         commit(path_to_local_repo = path_to_local_repo,
                #                                                commit_message = paste0("change to ", paste(filenames, collapse = ", "), " written in ", cave::present_script_path()),
                #                                                description = description)
                #                         }
                #
                #                         secretary::typewrite_bold("\nCommit Status:")
                #                         pretty_if_exists(x)
                #                         invisible(x)
                #         } else {
                #                 secretary::typewrite_error("Filenames", crayon::italic(paste(input_filenames, collapse = ", ")), "are not commitable. They either do not exist or are larger than 100MB.", log = log)
                #         }
                #
                # } else {
                #         secretary::typewrite_error("Local repository",
                #                                    crayon::italic(path_to_local_repo),
                #                                    "does not exist.",
                #                                    log = log)
                # }
        }
