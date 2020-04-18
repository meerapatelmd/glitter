#' Document, push changes, and install a public GitHub Package
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#' @inheritParams add_commit_all_this_repo
#' @import roxygen2
#' @importFrom devtools document
#' @importFrom devtools install_github
#' @export

doc_push_install_package <-
        function (commit_message, description = NULL)
                {

        #Updating documentation
        require(roxygen2)
        require(devtools)
        devtools::document()


        #Updating and Pushing to GitHub
        x <- add_commit_all_this_repo(commit_message = commit_message, description = description)
        pretty(x)
        push_this_repo()

        #Installing package by first getting URL of the remote
        git_url <- remote_url()

        #Installing it as either a public or an Enterprise GitHub repo
        if (grepl("github.com/patelm9", git_url, ignore.case = TRUE) == TRUE) {
                devtools::install_github(paste0("patelm9/", basename(getwd())))
        } else {
                devtools::install_git(url = git_url)
        }

}
