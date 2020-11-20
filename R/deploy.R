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

                        push(path = path_to_root)

}
