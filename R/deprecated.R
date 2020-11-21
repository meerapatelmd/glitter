#' @title
#' Open a GitHub Page in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @return
#' If a GitHub Page exists, it is opened in the browser. Otherwise, a message is returned in the console that states that a GitHub Page does not exist.
#'
#' @details
#' This function opens the GitHub Page URL returned by \code{\link{get_remote_urls}} if a GitHub Page exists for the repo.
#'
#' @seealso
#'  \code{\link[dplyr]{filter}}
#'  \code{\link[secretary]{typewrite}}
#'  \code{\link[utils]{browseURL}}
#' @family browse github
#' @export
#' @importFrom dplyr filter
#' @importFrom secretary typewrite
#' @importFrom utils browseURL

browse_gh_pages2 <-
        function(github_username,
                 repo) {

                .Deprecated()

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }

                repo_pages_info <-
                        repo_info %>%
                        dplyr::filter(has_pages == "TRUE")


                if (nrow(repo_pages_info) == 0) {

                        secretary::typewrite(repo, "does not have a GitHub Page.")

                } else {

                        utils::browseURL(url = repo_pages_info$pages_url)

                }

        }


#' @title
#' Open a GitHub Repo URL in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @seealso
#'  \code{\link[utils]{browseURL}}
#' @export
#' @importFrom utils browseURL

browse_repo_issues2 <-
        function(github_username,
                 repo) {

                .Deprecated()

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }


                utils::browseURL(url = repo_info$issues_page_url)


        }


#' @title
#' Open a GitHub Repo Issues Page in a Browser
#'
#' @inherit browse_github_functions description
#' @inheritParams browse_github_functions
#'
#' @seealso
#'  \code{\link[utils]{browseURL}}
#' @rdname browse_repo_issues
#' @export
#' @importFrom utils browseURL

browse_repo2 <-
        function(github_username,
                 repo) {

                .Deprecated()

                # repo <- "glitter"
                # github_username <- "meerapatelmd"

                repo_info <- get_repo_info(github_username = github_username,
                                           repo = repo)


                if (nrow(repo_info) == 0) {

                        stop(repo, " not found")
                }


                utils::browseURL(url = repo_info$html_url)


        }





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
                  ...) {

                .Deprecated(new = "deploy_all")




                        #Rewriting NAMESPACE
                        if (file.exists("NAMESPACE")) {
                                file.remove("NAMESPACE")
                        }

                        devtools::document()


                        #Updating and Pushing to GitHub
                        x <- ac(commit_msg = commit_message)

                        if (exists("x")) {
                                printMsg(x)
                                if (length(x) > 0) {
                                        push()
                                }
                        }


                        if (install) {


                                        #Installing package by first getting URL of the remote
                                        git_url <- remote_url()


                                        devtools::install_git(url = git_url)



                        }

                        if (build) {


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
                  commit_message = "update documentation",
                  description = NULL,
                  install = TRUE,
                  reset = FALSE,
                  has_vignettes = FALSE,
                  path = getwd())

                {


                .Deprecated(new = "deploy_pkg")


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











#' Stop if the directory does not exist
#' @export

stop_if_dir_not_exist <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                if (!(dir.exists(path_to_local_repo))) {

                        stop(path_to_local_repo, " doesn't exist")

                }

        }





#' Stop if not repo
#' @export


stop_if_not_git_repo <-
        function(path_to_local_repo = NULL) {

                .Deprecated()

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                if (!isRepo(path_to_local_repo = path_to_local_repo)) {

                        stop(path_to_local_repo, " is not a git repository")

                }

        }





