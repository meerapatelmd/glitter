#' Takes the command line message vector and prints a clean version in console. Deprecated for pretty() function.
#' @param glitter_output output vector from any glitter function
#' @export


pretty_git <-
        function(glitter_output) {
                .Deprecated()
                cat(glitter_output, sep = "\n")
        }
