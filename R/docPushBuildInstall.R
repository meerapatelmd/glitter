#' @title Document, Push, Install, and Build a Site
#' @seealso
#'  \code{\link[devtools]{document}}, \code{\link[devtools]{remote-reexports}}
#' @rdname docPushBuildInstall
#' @keywords internal
#' @export
#' @importFrom devtools document install_github install_git

docPushBuildInstall <-
        function (commit_message,
                  description = NULL,
                  install = TRUE,
                  build = TRUE,
                  verbose = TRUE,
                  ...)

                {

                suppressPackageStartupMessages(require(tidyverse))

                        #Rewriting NAMESPACE
                        if (file.exists("NAMESPACE")) {
                                file.remove("NAMESPACE")
                        }

                        devtools::document()


                        #Updating and Pushing to GitHub
                        x <- add_commit_all(
                                commit_message = commit_message,
                                description = description)

                        if (exists("x")) {
                                printMsg(x)
                                if (length(x) > 0) {
                                        push()
                                }
                        }


                        if (install) {


                                        #Installing package by first getting URL of the remote
                                        git_url <- remote_url()

                                        #Installing it as either a public or an Enterprise GitHub repo
                                        if (grepl("github.com/patelm9", git_url, ignore.case = TRUE) == TRUE) {
                                                devtools::install_github(paste0("patelm9/", basename(getwd())))
                                        } else {

                                                devtools::install_git(url = git_url)

                                        }


                        }

                        if (build) {

                                require(tidyverse)

                                build_push_site(...)

                                if (!isWorkingTreeClean()) {

                                        commitResponse <- add_commit_all(commit_message = "final file commits after build site")
                                        if (verbose) {

                                                printMsg(commitResponse)

                                        }

                                        push()

                                }

                        }

}
