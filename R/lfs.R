#' @title
#' Install LFS
#' @param lfs_ext extensions of files that will be large and will need to be tracked using the lfs
#' @export

install_lfs <-
        function(path = getwd(), lfs_ext = c("xlsx", "csv", "RData")) {

                path <- extend_path(path)

                command1 <-
                sprintf(
                        "cd\n
                        cd %s\n
                        git lfs install\n", path
                        )

                command2 <-
                        sprintf("git lfs track '*.%s'\n", lfs_ext)

                command3 <- "git add .gitattributes\ngit commit -m '+: .gitattribute for lfs tracking'\n"

                command <- sprintf("%s%s%s", command1, command2, command3)

                response <- system(command = command,
                                   intern = TRUE)

                print_response(response)
        }
