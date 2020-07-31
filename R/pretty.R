#' Takes the command line message vector and prints a clean version in console.
#' @param glitter_output output vector from any glitter function
#' @export


pretty <-
        function(glitter_output) {
                .Deprecated(new = "print_msg")
                cat(glitter_output, sep = "\n")
        }
