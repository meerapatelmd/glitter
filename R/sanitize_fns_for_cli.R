#' Subsitute spaces and special characters with the backslash for a CLI command
#' @export

sanitize_fns_for_cli <-
        function(vector) {
                .Deprecated("formatCli")
               x <- gsub(" ", "\\ ", vector, fixed = TRUE)
               x <- gsub("(", "\\(", x, fixed = TRUE)
               x <- gsub(")", "\\)", x, fixed = TRUE)
               return(x)
        }



