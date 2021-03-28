#' @title
#' Add and Commit FF
#' @rdname ac_ff
#' @export

ac_ff <-
  function(..., generic_commit_msg) {
    function(commit_msg = eval(generic_commit_msg),
             verbose = TRUE) {
      path <- root(path = getwd())
      ac(
        commit_msg = commit_msg,
        ...,
        path = path,
        verbose = verbose
      )
    }
  }


#' @title
#' Add and Commit DESCRIPTION
#' @rdname ac_desc
#' @export

ac_desc <-
  ac_ff("DESCRIPTION",
    generic_commit_msg = "update DESCRIPTION"
  )


#' @title
#' Add and Commit README
#'
#' @rdname ac_readme
#' @export

ac_readme <-
  ac_ff("README.md", "README.Rmd",
    generic_commit_msg = "update README.md"
  )

#' @title
#' Add and Commit Pkgdown YAML
#'
#' @rdname ac_pkgdown_yml
#' @export

ac_pkgdown_yml <-
  ac_ff("_pkgdown.yml",
    generic_commit_msg = "update pkgdown yaml"
  )
