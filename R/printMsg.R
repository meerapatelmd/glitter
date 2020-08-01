#' Print the Command Line Response
#' @description This function prints any command line response from a glitter function if the response is of length greater than 0.
#' @param git_msg Output from a glitter function.


printMsg <-
        function(git_msg) {
                if (length(git_msg)) {
                        cat(git_msg, sep = "\n")
                }
        }
