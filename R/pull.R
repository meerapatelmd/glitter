#' Pull a GitHub repo based on the path to local repo
#' @param path_to_local_repo full path to directory of the repo to be pulled. If the path does not exist, it will be cloned to the parent directory.
#' @return pulled or cloned repo at the given path_to_local_repo
#' @importFrom crayon red
#' @importFrom typewriteR tell_me
#' @export

pull <-
        function(path_to_local_repo) {

                if (dir.exists(path_to_local_repo)) {
                        x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git pull"
                        ), intern = TRUE
                        )

                        return(x)
                } else {
                        typewriteR::tell_me(crayon::red(path_to_local_repo, "does not exist.\n"))
                        github_username <- readline("Enter the GitHub username that this repo belongs to: ")
                        x <-
                        system(paste0("cd\n",
                                      "cd ", dirname(path_to_local_repo),"\n",
                                      "git clone ", paste0("https://github.com/", github_username, "/",
                                                           basename(path_to_local_repo),
                                                           ".git"
                                      ), "\n"
                        ), intern = TRUE
                        )

                        return(x)
                }
        }
