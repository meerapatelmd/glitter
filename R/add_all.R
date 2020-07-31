#' Add All Files to a Commit in a Local GitHub Repository
#' @param path_to_local_repo Full path to local repository. If NULL, adds all the files
#' @importFrom secretary typewrite_error
#' @import dplyr
#' @import rubix
#' @import purrr
#' @export


add_all <-
        function(path_to_local_repo = NULL) {

                        if (is.null(path_to_local_repo)) {

                                path_to_local_repo <- getwd()
                        }

                        stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                        stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                        large_files <-
                        list.files(path_to_local_repo, full.names = TRUE) %>%
                                rubix::map_names_set(cave::size_in_mb) %>%
                                purrr::keep(function(x) x > 1) %>%
                                names()

                        if (length(large_files) > 0) {


                                stop("Files greater than 100 MB found: ", paste(large_files, collapse = ", "))

                        }

                        system(paste0("cd\n",
                                              "cd ", path_to_local_repo,"\n",
                                              "git add ."),
                                       intern = FALSE)

        }
