#' @title
#' Commit
#' @rdname commit
#' @export

commit <-
        function(commit_msg,
                 path = getwd(),
                 verbose = TRUE) {


                command <-
                        c(starting_command(path = path),
                          paste0("git commit -m '", commit_msg, "'")) %>%
                        paste(collapse = "\n")

                commit_response <-
                        suppressWarnings(
                                system(command = command,
                                       intern = TRUE))

                if (verbose) {

                        cli::cat_line()
                        cli::cat_rule(secretary::yellowTxt("Commit Response"))

                        if ("no changes added to commit" %in% commit_response) {
                                secretary::typewrite_italic(secretary::redTxt("\tNo changes added to the commit."))
                        }

                        cat(paste0("\t\t", commit_response), sep = "\n")

                        cli::cat_line()
                }

                invisible(commit_response)
        }
