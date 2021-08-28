#' @title
#' Deploy a Package
#'
#' @inheritParams devtools::install_git
#' @inheritParams push
#' @param commit_msg        commit message
#' @param description           description to extend the commit message if desired, Default: NULL
#' @param install               If TRUE, installs the package after the changes are pushed to the remote, Default: TRUE
#' @param reset                 If TRUE, restart R after installation is complete. Default: TRUE.
#'
#' @return
#' A freshly packed local package committed to the remote that is by default also installed with vignettes, if applicable.
#'
#' @seealso
#'  \code{\link[devtools]{document}},\code{\link[devtools]{build_vignettes}},\code{\link[devtools]{remote-reexports}}
#' @rdname deploy_pkg
#' @export
#' @importFrom desc desc_get_version
#' @importFrom secretary typewrite press_enter
#' @importFrom glue glue
#' @importFrom git2r tag_delete tag
#' @importFrom devtools document install_github install_git
#' @importFrom stringr str_replace_all
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom cli cat_line cat_rule

deploy_pkg <-
  function(
           commit_msg = "deploy pkg using glitter",
           tag = NULL,
           remote_name = "origin",
           remote_branch = "master",
           install = TRUE,
           reset = FALSE,
           build_vignettes = FALSE,
           path = getwd(),
           ref = "HEAD",
           git = c("auto", "git2r", "external"),
           dependencies = NA,
           upgrade = "never",
           force = FALSE,
           quiet = FALSE,
           build = TRUE,
           build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
           build_manual = FALSE,
           repos = getOption("repos"),
           type = getOption("pkgType")) {

    current_wd <- getwd()
    setwd(path)
    on.exit(setwd(current_wd))


    # Getting Version from the DESCRIPTION.
    # Desc::desc_get_version() returns a hidden list and it is
    # converted to character
    version_in_desc <-
      as.character(desc::desc_get_version())


    tags_list <- list_tags(path = path)
    most_recent_tag <- names(tags_list)[1]

    if (is.null(tag)) {

      secretary::typewrite(glue::glue("   No tag provided.\n  Version in DESCRIPTION is '{version_in_desc}'.\n  Latest tag is '{most_recent_tag}'.\n  Continue? "),
                           timepunched = FALSE)
      secretary::press_enter()

    } else if  (tag %in% names(tags_list)) {

      secretary::typewrite(glue::glue("   Tag '{tag}' has already been used and will be updated to this commit.\n  Version in DESCRIPTION is '{version_in_desc}'.\n  Latest tag is '{most_recent_tag}'.\n  Continue? "), timepunched = FALSE)

      secretary::press_enter()


      delete_local_tag(path = path,
                       tag = tag)

      delete_remote_tag(path = path,
                        tag  = tag,
                        remote_name = remote_name)

    } else {

      secretary::typewrite(glue::glue("   Tag '{tag}' is new.\n  Version in DESCRIPTION is '{version_in_desc}'.\n  Latest tag is '{most_recent_tag}'.\n  Continue? "), timepunched = FALSE)
      secretary::press_enter()

    }

    if (!is.null(tag)) {

    git2r::tag(object = path,
               name = tag)

    }



    # Rewriting NAMESPACE
    if (file.exists("NAMESPACE")) {
      file.remove("NAMESPACE")
    }
    devtools::document()



    # Updating and Pushing to GitHub
    x <- ac(path = path,
            commit_msg = commit_msg)

    if (exists("x")) {
      print_response(x)

        push_tag(
          path = path,
          remote_name = remote_name,
          remote_branch = remote_branch,
          verbose = TRUE
        )
    }


    if (install) {

      # Installing package by first getting URL of the remote
      git_url <- remote_url(path = path,
                            remote_name = remote_name)

      if (grepl("git[@]{1}.*?[:]{1}.*[.]{1}git$", git_url)) {
        repo <-
        stringr::str_replace_all(
          string = git_url,
          pattern = "(^git[@]{1}.*?):(.*?)/(.*?).git$",
          replacement = "\\2/\\3"
        )

        secretary::typewrite(glue::glue("\nGit URL: {git_url}\nGit Repo: {repo}\n"),
                             timepunched = F)

        # Install
        devtools::install_github(
          repo = repo,
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
          type = type
        )

      } else if (grepl("https[:]{1}[/]{1}[/]{1}github[.]{1}com[/]{1}.*[/]{1}.*[.]{1}git$",
                       git_url)) {
        repo <-
          stringr::str_replace_all(
            string = git_url,
            pattern = "(^https://github.com)/(.*?)/(.*?)([.]{1}git$)",
            replacement = "\\2/\\3"
          )

        secretary::typewrite(glue::glue("\nGit URL: {git_url}\nGit Repo: {repo}\n"),
                             timepunched = F)
        # Install
        devtools::install_github(
          repo   = repo,
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
          type = type
        )


      } else if (grepl("https[:]{1}[/]{1}[/]{1}github[.]{1}com[/]{1}.*[/]{1}.*$",
                      git_url)) {

        repo <-
          stringr::str_replace_all(
            string = git_url,
            pattern = "(^https://github.com)/(.*?)/(.*$)",
            replacement = "\\2/\\3"
          )

        secretary::typewrite(glue::glue("\nGit URL: {git_url}\nGit Repo: {repo}\n"),
                             timepunched = F)
        # Install
        devtools::install_github(
          repo   = repo,
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
          type = type
        )


      } else {

        secretary::typewrite(glue::glue("\nGit URL: {git_url}\nGit Repo: Not Discovered\n"),
                             timepunched = F)

      # Install
      devtools::install_git(
        url = git_url,
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
        type = type
      )
      }
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
#' @importFrom desc desc_get_version
#' @importFrom secretary typewrite press_enter
#' @importFrom glue glue
#' @importFrom git2r tag_delete tag
#' @importFrom devtools document install_github install_git
#' @importFrom stringr str_replace_all
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom cli cat_line cat_rule
deploy_gh_pages <-
  function(commit_msg = "deploy GitHub Pages using glitter",
           remote_name = "origin",
           remote_branch = "master",
           path = getwd(),
           examples = TRUE,
           run_dont_run = FALSE,
           seed = 1014,
           lazy = TRUE,
           override = list(),
           preview = FALSE,
           devel = TRUE,
           new_process = !devel,
           install = !devel) {
    current_wd <- getwd()
    setwd(path)
    on.exit(setwd(current_wd))

    # Create _pkgdown.yml file if it does not exist
    if (!file.exists("_pkgdown.yml")) {
      usethis::use_pkgdown()
    }

    if ("docs" %in% list.files()) {
      unlink("docs", recursive = TRUE)
    }
    gi_rm("docs")


    # Build pkgdown Site
    pkgdown::build_site(
      examples = examples,
      run_dont_run = run_dont_run,
      seed = seed,
      lazy = lazy,
      override = override,
      preview = preview,
      devel = devel,
      new_process = new_process,
      install = install
    )


    add(
      path = "docs",
      recursive = TRUE
    )

    add("_pkgdown.yml")


    commit(commit_msg = commit_msg)

    push(
      path = path,
      remote_name = remote_name,
      remote_branch = remote_branch,
      verbose = TRUE
    )
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
#' @importFrom desc desc_get_version
#' @importFrom secretary typewrite press_enter
#' @importFrom glue glue
#' @importFrom git2r tag_delete tag
#' @importFrom devtools document install_github install_git
#' @importFrom stringr str_replace_all
#' @importFrom usethis use_pkgdown
#' @importFrom pkgdown build_site
#' @importFrom cli cat_line cat_rule
deploy_all <-
  function(commit_msg = "deploy pkg and GitHub Pages using glitter",
           tag = NULL,
           remote_name = "origin",
           remote_branch = "master",
           path = getwd(),
           install = TRUE,
           reset = FALSE,
           build_vignettes = FALSE,
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
           repos = getOption("repos"),
           type = getOption("pkgType")) {
    cli::cat_line()
    cli::cat_rule("Deploying Package")
    deploy_pkg(
      commit_msg = commit_msg,
      tag = tag,
      remote_name = remote_name,
      remote_branch = remote_branch,
      install = install,
      reset = reset,
      build_vignettes = build_vignettes,
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
      repos = repos,
      type = type
    )


    cli::cat_line()
    cli::cat_rule("Deploying GH Pages")
    deploy_gh_pages(
      path = path,
      remote_name = remote_name,
      remote_branch = remote_branch,
      examples = examples,
      run_dont_run = run_dont_run,
      seed = seed,
      lazy = lazy,
      override = override,
      preview = preview,
      devel = devel,
      new_process = new_process,
      install = !devel
    )
  }
