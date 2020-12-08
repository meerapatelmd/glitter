#' @title
#' Deploy a Package
#'
#' @description
#' This function automatically documents, pushes, and installs a package, assuming that the basename fo the working directory is the same as the repo as in patelm9/{repo}. If the URL of the GitHub remote belongs to MSKCC, the package is instead installed using a Git hyperlink.
#'
#' @inheritParams devtools::install_git
#' @param commit_msg        commit message
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
#' @export
#' @importFrom devtools document build_vignettes install_git

deploy_pkg <-
        function (
                commit_msg = "deploy pkg using glitter",
                install = TRUE,
                reset = FALSE,
                has_vignettes = TRUE,
                path = getwd(),
                ref = NULL,
                git = c("auto", "git2r", "external"),
                dependencies = NA,
                upgrade = "never",
                force = FALSE,
                quiet = FALSE,
                build = TRUE,
                build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
                build_manual = FALSE,
                build_vignettes = FALSE,
                repos = getOption("repos"),
                type = getOption("pkgType"))

        {

                current_wd <- getwd()
                setwd(path)
                on.exit(setwd(current_wd))


                #Rewriting NAMESPACE
                if (file.exists("NAMESPACE")) {
                        file.remove("NAMESPACE")
                }
                devtools::document()


                if (has_vignettes) {

                        devtools::build_vignettes()
                        gi_rm("doc", "doc/")

                }



                #Updating and Pushing to GitHub
                x <- ac(commit_msg = commit_msg)

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
                                              ref = ref,
                                              git = git,
                                              dependencies = dependencies,
                                              upgrade = upgrade,
                                              force = force,
                                              quiet = quiet,
                                              build = build,
                                              build_opts = build_opts,
                                              build_manual = build_manual,
                                              build_vignettes = build_vignettes,
                                              repos = repos,
                                              type = type)


                }

                if (reset) {

                        invisible(.rs.restartR())

                }

        }


#' @title
#' Re-Build and Push GitHub Pages
#'
#' @description
#' This unlinks the docs subdirectory, runs devtools document function, and writes a new docs/ directory using the pkgdown build_site function.
#'
#' @inheritParams deploy_pkg
#' @inheritParams pkgdown::build_site
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname deploy_gh_pages
#' @export
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site

deploy_gh_pages <-
        function(commit_msg = "deploy GitHub Pages using glitter",
                 path = getwd(),
                 examples = TRUE,
                 run_dont_run = FALSE,
                 seed = 1014,
                 lazy = TRUE,
                 override = list(),
                 preview = FALSE,
                 devel = TRUE,
                 new_process = !devel,
                 install = !devel)

                {

                        current_wd <- getwd()
                        setwd(path)
                        on.exit(setwd(current_wd))

                        # Create _pkgdown.yml file if it does not exist
                        if (!file.exists("_pkgdown.yml")) {
                                usethis::use_pkgdown()
                        }

                        if ("docs" %in% list.files()) {
                                unlink("docs",recursive = TRUE)
                        }
                        gi_rm("docs")


                        # #Rewriting NAMESPACE
                        # if (file.exists("NAMESPACE")) {
                        #         file.remove("NAMESPACE")
                        # }
                        # devtools::document()


                        # Build pkgdown Site
                        pkgdown::build_site(examples = examples,
                                            run_dont_run = run_dont_run,
                                            seed = seed,
                                            lazy = lazy,
                                            override = override,
                                            preview = preview,
                                            devel = devel,
                                            new_process = new_process,
                                            install = install)


                        add(path = "docs",
                            recursive = TRUE)

                        add("_pkgdown.yml")


                        commit(commit_msg = commit_msg)

                        push()

}


#' @title
#' Deploy a Package and GitHub Pages at Once
#'
#' @inheritParams deploy_pkg
#' @inheritParams deploy_gh_pages
#' @seealso
#'  \code{\link[usethis]{use_pkgdown}}
#'  \code{\link[pkgdown]{build_site}}
#' @rdname deploy_all
#' @export

deploy_all <-
        function(commit_msg = "deploy pkg and GitHub Pages using glitter",
                 path = getwd(),
                 install = TRUE,
                 reset = FALSE,
                 has_vignettes = TRUE,
                 ref = NULL,
                 examples = TRUE,
                 run_dont_run = FALSE,
                 seed = 1014,
                 lazy = TRUE,
                 override = list(),
                 preview = FALSE,
                 devel = TRUE,
                 new_process = !devel,
                 git = c("auto", "git2r", "external"),
                 dependencies = NA,
                 upgrade = "never",
                 force = FALSE,
                 quiet = FALSE,
                 build = TRUE,
                 build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
                 build_manual = FALSE,
                 build_vignettes = FALSE,
                 repos = getOption("repos"),
                 type = getOption("pkgType"))

        {


                cli::cat_line()
                cli::cat_rule("Deploying Package")
                deploy_pkg(commit_msg = commit_msg,
                           install = install,
                           reset = reset,
                           has_vignettes = has_vignettes,
                           path = path,
                           ref = ref,
                           git = git,
                           dependencies = dependencies,
                           upgrade = upgrade,
                           force = force,
                           quiet = quiet,
                           build = build,
                           build_opts = build_opts,
                           build_manual = build_manual,
                           build_vignettes = build_vignettes,
                           repos = repos,
                           type = type)


                cli::cat_line()
                cli::cat_rule("Deploying GH Pages")
                deploy_gh_pages(path = path,
                                examples = examples,
                                run_dont_run = run_dont_run,
                                seed = seed,
                                lazy = lazy,
                                override = override,
                                preview = preview,
                                devel = devel,
                                new_process = new_process,
                                install = !devel)

        }
