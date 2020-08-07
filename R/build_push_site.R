#' Build and Push docs/ dir For GitHub Pages
#' @description
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname build_push_site
#' @keywords internal
#' @export
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site

build_push_site <-
        function (commit_message = "update GitHub Page",
                  update_gitignore = TRUE,
                  lazy = TRUE,
                  preview = FALSE,
                  devel = TRUE,
                  ...)

                {

                        # Create _pkgdown.yml file if it does not exist
                        if (!file.exists("_pkgdown.yml")) {
                                usethis::use_pkgdown()
                        }

                        # Build pkgdown Site
                        pkgdown::build_site(lazy = lazy,
                                            preview = preview,
                                            devel = devel,
                                            ...
                                            )


                        # Remove "docs/" from gitignore if present
                        if (update_gitignore) {

                                rmFromGitIgnore("docs/",
                                                commit = TRUE,
                                                path_to_local_repo = getwd())

                        }


                        # Updating and Pushing to GitHub
                        commitMessage <- add_commit_some(
                                                commit_message = commit_message,
                                                filenames = list.files(path = "docs",
                                                                       full.names = TRUE)
                                                )


                        printMsg(commitMessage)

                        push()

}
