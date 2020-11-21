#' Commit History of a File
#' @description This function can be especially useful in cases where a deleted files is being tracked down.
#' @export

list_file_commits <-
        function(file,
                 path = getwd(),
                 verbose = TRUE) {

                logResponse <-
                        system(paste0("cd\ncd ", path, "\ngit log --all -- ", file),
                               intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }

#' Commit History of a File
#' @description This function can be especially useful in cases where a deleted files is being tracked down.
#' @export

last_file_commit <-
        function(file,
                 path = getwd()) {

                file_commits <-
                        list_file_commits(file = file,
                                          path = path,
                                          verbose = FALSE)

                # Index of first commit in vector
                index <-
                        grep(pattern = "^commit [^ ]{1,}$",
                             x = file_commits)[1]

                stringr::str_replace(file_commits[index],
                                     pattern = "(commit )(.*$)",
                                     replacement = "\\2")
        }
