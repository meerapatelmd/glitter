#' Document, push changes, and install a public GitHub Package
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#' @importFrom usethis use_pkgdown
#' @import pkgdown
#' @importFrom devtools document
#' @importFrom devtools install_github
#' @export

build_push_site <-
        function (commit_message = "update GitHub Page")

                {

                        # Create _pkgdown.yml file if it does not exist
                        if (!file.exists("_pkgdown.yml")) {
                                usethis::use_pkgdown()
                        }

                        pkgdown::build_site()


                        #Updating and Pushing to GitHub
                        x <- add_commit_all(
                                commit_message = commit_message)

                        print_if_has_length(x)

                                if (length(x) > 0) {
                                        push()
                                }

}
