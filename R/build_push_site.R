#' @title
#' Re-Build and Push GitHub Pages
#'
#' @description
#' This unlinks the docs subdirectory, runs devtools document function, and writes a new docs/ directory using the pkgdown build_site function.
#'
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname build_push_site
#' @export
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom devtools document

build_push_site <-
        function (commit_message = "update GitHub Page",
                  lazy = TRUE,
                  preview = FALSE,
                  devel = TRUE,
                  ...)

                {

                        # Create _pkgdown.yml file if it does not exist
                        if (!file.exists("_pkgdown.yml")) {
                                usethis::use_pkgdown()
                        }

                        if ("docs" %in% list.files()) {
                                unlink("docs",recursive = TRUE)
                        }


                        devtools::document()
                        add(all = TRUE)
                        com(msg = "refresh Rds before updating GitHub Pages")
                        push()


                        # Build pkgdown Site
                        pkgdown::build_site(lazy = lazy,
                                            preview = preview,
                                            devel = devel,
                                            ...
                                            )
                        add(all = TRUE)
                        com(msg = "update GH Pages")
                        push()

}
