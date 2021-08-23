#' @title
#' Knit Vignettes
#'
#' @description
#' Knit standard Rmd vignettes along
#' with asis vignettes tagged with a `asis` suffix in its filename
#' to the `doc` folder.
#'
#' @inheritParams devtools::build_vignettes
#' @seealso
#'  \code{\link[devtools]{build_vignettes}}
#' @rdname knit_vignettes
#' @export
#' @importFrom devtools build_vignettes

knit_vignettes <-
        function(dependencies = "VignetteBuilder",
                 clean = TRUE,
                 upgrade = "never",
                 quiet = TRUE,
                 install = TRUE,
                 keep_md = TRUE) {


                gi_rm("doc", "doc/")

                devtools::build_vignettes(
                        pkg = ".",
                        dependencies = dependencies,
                        clean = clean,
                        upgrade = upgrade,
                        quiet = quiet,
                        install = install,
                        keep_md = keep_md)

                asis_files <-
                        list.files(
                                path = "vignettes",
                                pattern = "[.]{1}asis$",
                                full.names = TRUE
                        )

                if (length(asis_files) > 0) {
                        for (i in seq_along(asis_files)) {
                                asis_file <- asis_files[i]
                                file_to_copy <- file.path("doc", stringr::str_remove(basename(asis_file),
                                                                                     pattern = "[.]{1}asis$"
                                ))
                                new_file <- file.path("vignettes", basename(file_to_copy))
                                file.copy(
                                        from = file_to_copy,
                                        to = new_file
                                )
                        }
                }
        }
