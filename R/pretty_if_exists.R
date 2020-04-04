#' Prints the git message in console if the message is of length greater than zero
#' @param git_msg output from a glitter git command
#' @export

print_if_message_exists <-
        function(git_msg) {
                if (length(git_msg) > 0) {
                        pretty(git_msg)
                }
        }
