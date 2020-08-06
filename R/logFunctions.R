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



#' Search Deleted File
#' @export


deletedFileHistory <-
        function(repo_path = NULL,
                 verbose = TRUE) {

                if (is.null(repo_path)) {
                        repo_path <- getwd()
                }

                logResponse <-
                system(paste0("cd\ncd ", repo_path,"\ngit log --diff-filter=D --summary | grep delete"),
                       intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }

#' Commit History of a File
#' @description This function can be especially useful in cases where a deleted files is being tracked down.
#' @export

fileCommitHistory <-
        function(filePath,
                 repo_path,
                 verbose = TRUE) {


                filePath <- path.expand(paste0(repo_path, "/", filePath))

                logResponse <-
                system(paste0("cd\ncd ", repo_path, "\ngit log --all -- ", filePath),
                       intern = TRUE)

                if (verbose) {
                        printMsg(logResponse)
                }

                invisible(logResponse)
        }

#' Retrieve Deleted File
#' @export

retrieveLostFile <-
        function(sha,
                 filePath,
                 verbose = TRUE,
                 repo_path = NULL) {

                if (is.null(repo_path)) {
                        repo_path <- getwd()
                }

                filePath <- path.expand(filePath)

                checkoutResponse <-
                        system(paste0("cd\ncd ", repo_path,"\ngit checkout ", sha, "^ -- ", filePath),
                               intern = TRUE)

                if (verbose) {
                        printMsg(checkoutResponse)
                }

                invisible(checkoutResponse)
        }


