#' Subsitute spaces and special characters with the backslash for a CLI command
#' @export

formatCli <-
        function(vector) {
               x <- gsub(" ", "\\ ", vector, fixed = TRUE)
               x <- gsub("(", "\\(", x, fixed = TRUE)
               x <- gsub(")", "\\)", x, fixed = TRUE)
               x
        }



