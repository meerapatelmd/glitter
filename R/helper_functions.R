




mk_local_path_if_null <-
        function(path_to_local_repo) {

                if (is.null(path_to_local_repo)) {
                        assign("path_to_local_repo", getwd(), envir = parent.frame())
                }
        }



extend_path <-
        function(...) {

                normalizePath(path = file.path(...), mustWork = TRUE)
        }


starting_command <-
        function(path_to_local_repo) {

                c("cd",
                  paste0("cd ", path_to_local_repo)) %>%
                        paste(collapse = "\n")

        }
