#' @title Clone a Git Repository
#'
#' @param remote_url            Web url of repository to clone
#' @param destination_path      Path of the destination directory to which the repo will be cloned.
#'
#' @return
#' Cloned repo in the path of {destination_path/repo name} if the directory does not exist. Otherwise an error is thrown.
#'
#' @export
#' @importFrom cave strip_fn
#' @importFrom magrittr %>%
#' @importFrom purrr map

clone <-
        function(remote_url, destination_path) {

                local_repo_path <-
                remote_url %>%
                        cave::strip_fn() %>%
                        purrr::map(~paste0(destination_path, "/", .)) %>%
                        unlist()

                if (!dir.exists(local_repo_path)) {

                                system(paste0("cd\n",
                                              "cd ", destination_path,"\n",
                                              "git clone ", remote_url, "\n"
                                              ))


                } else {

                                stop(local_repo_path, " already exists")

                }
        }
