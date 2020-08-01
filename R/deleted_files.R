#' Get a list of deleted files in a repo
#' @description Lists all the deleted files according to the git status message returned by the status function
#' @return The Git Status message and deleted files are printed in the console while the vector of the deleted filenames are invisibly returned.
#' @param path_to_local_repo path to local repo
#' @importFrom stringr str_replace_all
#' @importFrom secretary typewrite_italic
#' @importFrom secretary typewrite_bold
#' @keywords internal
#' @export

deleted_files <-
        function(path_to_local_repo = NULL,
                 verbose = TRUE) {

                .Deprecated()

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()
                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)
                stop_if_not_git_repo(path_to_local_repo = path_to_local_repo)


                status_msg <- status(path_to_local_repo = path_to_local_repo)
                files <- grep("^\tdeleted:", status_msg, value = TRUE)

                files_df <- tibble::tibble(files)
                files_df <-
                        files_df %>%
                        tidyr::extract(col = files,
                                       into = c("File Type", "File Path"),
                                       regex = "(^.*?[:]{1}[ ]{1,})([^ ]{1}.*$)")




        }

