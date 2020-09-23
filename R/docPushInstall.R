#' @title Document, Push, and Install a GitHub Package
#' @description
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#'
#' @param commit_message        commit message
#' @param description           description to extend the commit message if desired, Default: NULL
#' @param install               If TRUE, installs the package after the changes are pushed to the remote, Default: TRUE
#' @param has_vignettes         If TRUE, vignettes in the vignette/ subdir are built, pushed, and also built upon installation. Default: TRUE
#' @param reset                 If TRUE, restart R after installation is complete. Default: TRUE.
#'
#' @return
#' A freshly packed local package committed to the remote that is by default also installed with vignettes, if applicable.
#'
#' @seealso
#'  \code{\link[devtools]{document}},\code{\link[devtools]{build_vignettes}},\code{\link[devtools]{remote-reexports}}
#' @rdname docPushInstall
#' @keywords internal
#' @export
#' @importFrom devtools document build_vignettes install_github install_git

docPushInstall <-
        function (
                  commit_message,
                  description = NULL,
                  install = TRUE,
                  reset = TRUE,
                  has_vignettes = FALSE)

                {

                        #suppressPackageStartupMessages(require(tidyverse))
                        suppressPackageStartupMessages(require(rlang))

                        #Rewriting NAMESPACE
                        if (file.exists("NAMESPACE")) {
                                file.remove("NAMESPACE")
                        }


                        devtools::document()


                        if (has_vignettes) {

                                devtools::build_vignettes()
                                rmFromGitIgnore("doc", "doc/")

                        }



                        #Updating and Pushing to GitHub
                        x <- add_commit_all(
                                commit_message = commit_message,
                                description = description
                                )

                        if (exists("x")) {

                                printMsg(x)

                                if (length(x) > 0) {

                                        push()

                                }
                        }


                        if (install) {

                                #Installing package by first getting URL of the remote
                                git_url <- remote_url()



                                # Install
                                devtools::install_git(url = git_url)


                        }

                        if (reset) {

                                invisible(.rs.restartR())

                        }

        }

