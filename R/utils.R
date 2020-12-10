#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' Subsitute spaces and special characters with the backslash for a CLI command
#' @export

formatCli <-
        function(vector) {
                x <- gsub(" ", "\\ ", vector, fixed = TRUE)
                x <- gsub("(", "\\(", x, fixed = TRUE)
                x <- gsub(")", "\\)", x, fixed = TRUE)
                x
        }
