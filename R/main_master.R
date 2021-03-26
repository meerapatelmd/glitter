#' @title
#' Is the cardinal branch called `main`?
#'
#' @rdname is_main
#' @export
is_main <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "main" %in% repo_branches
        }

#' @title
#' Is the cardinal branch called `master`?
#'
#' @rdname is_master
#' @export
is_master <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "master" %in% repo_branches
        }
