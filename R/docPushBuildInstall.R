#' Document, push changes, and install a public GitHub Package
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#' @importFrom magrittr %>%
#' @import roxygen2
#' @import pkgdown
#' @importFrom devtools document
#' @importFrom devtools install_github
#' @keywords internal
#' @export

docPushBuildInstall <-
        function (commit_message,
                  description = NULL,
                  install = TRUE,
                  build = TRUE,
                  ...)

                {

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

                        invisible(.rs.restartR())

}
