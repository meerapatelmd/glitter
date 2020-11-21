#' @title
#' Deploy a Package
#'
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
#' @rdname deploy_pkg
#' @keywords internal
#' @export
#' @importFrom devtools document build_vignettes install_github install_git

deploy_pkg <-
        function (
                commit_message = "update documentation",
                install = TRUE,
                reset = FALSE,
                has_vignettes = FALSE,
                path = getwd())

        {


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
                x <- ac(commit_msg = commit_message,
                        pattern = NULL,
                        path = path)

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
                        devtools::install_git(url = git_url,
                                              upgrade = "never")


                }

                if (reset) {

                        invisible(.rs.restartR())

                }

        }







#' @title
#' Update Package and GitHub Pages
#'
#' @description
#' This unlinks the docs subdirectory, runs devtools document function, and writes a new docs/ directory using the pkgdown build_site function.
#'
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname deploy_all
#' @export
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom devtools document

deploy_all <-
        function(path = getwd(),
                 lazy = TRUE,
                 preview = FALSE,
                 devel = TRUE,
                 ...)

        {

                path_to_root <- root(path = path)


                #Rewriting NAMESPACE
                if (file.exists("NAMESPACE")) {
                        file.remove("NAMESPACE")
                }
                devtools::document()


                # Create _pkgdown.yml file if it does not exist
                if (!file.exists("_pkgdown.yml")) {
                        usethis::use_pkgdown()
                }

                if ("docs" %in% list.files(path = path_to_root)) {
                        unlink("docs",recursive = TRUE)
                }

                # Build pkgdown Site
                pkgdown::build_site(lazy = lazy,
                                    preview = preview,
                                    devel = devel,
                                    ...
                )

                ac(recursive = TRUE,
                   commit_msg = "update Package and GitHub Page")

                push(path = path_to_root)

                devtools::install_git(url = remote_url(path_to_root), upgrade = "never")

        }









#' @title
#' Re-Build and Push GitHub Pages
#'
#' @description
#' This unlinks the docs subdirectory, runs devtools document function, and writes a new docs/ directory using the pkgdown build_site function.
#'
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname deploy_gh_pages
#' @export
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom devtools document

deploy_gh_pages <-
        function(path = getwd(),
                  lazy = TRUE,
                  preview = FALSE,
                  devel = TRUE,
                  ...)

                {

                        path_to_root <- root(path = path)

                        # Create _pkgdown.yml file if it does not exist
                        if (!file.exists("_pkgdown.yml")) {
                                usethis::use_pkgdown()
                        }

                        if ("docs" %in% list.files(path = path_to_root)) {
                                unlink("docs",recursive = TRUE)
                        }


                        #Rewriting NAMESPACE
                        if (file.exists("NAMESPACE")) {
                                file.remove("NAMESPACE")
                        }
                        devtools::document()



                        # Build pkgdown Site
                        pkgdown::build_site(lazy = lazy,
                                            preview = preview,
                                            devel = devel,
                                            ...
                                            )

                        ac(path = file.path(path_to_root, "docs"),
                           recursive = TRUE,
                           commit_msg = "update GitHub Page")

                        ac("_pkgdown.yml",
                           commit_msg = "update file")

                        push(path = path_to_root)

}
