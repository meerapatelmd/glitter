#' Get all deleted files in the current wd
#' @export

deleted_files_in_wd <-
        function() {
                out <- deleted_files(path_to_local_repo = getwd())
                out <- grep("^[.]{2}.*",
                            out,
                            invert = TRUE,
                            value = TRUE)
                if (length(out) > 0) {
                        secretary::typewrite_bold("\nDeleted Files in:", getwd(), line_number = 0, add_to_readme = FALSE)
                        pretty_if_exists(out)
                        invisible(out)
                } else {
                        secretary::typewrite_italic("No deleted files in", getwd())
                }
        }
