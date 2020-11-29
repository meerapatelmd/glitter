#' @title Git Diff
#' @description
#' Show unstaged changes between your index and working directory
#' @export


diff <-
        function(path = NULL) {

                if (is.null(path)) {

                        path <- getwd()

                }


                diffMessage <-
                        system(paste0("cd\n",
                                      "cd ", path,"\n",
                                      "git diff"
                        ), intern = TRUE
                        )

                printMsg(diffMessage)

        }
