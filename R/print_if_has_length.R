#' Prints the git message in console if the message is of length greater than zero
#' @param git_msg output from a glitter git command
#' @keywords internal
#' @export

print_if_has_length <-
        function(git_msg) {

                .Deprecated("printMsg")

                if (length(git_msg) > 0) {
                        cat(git_msg, sep = "\n")
                }
        }
