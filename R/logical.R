#' Does the GitHub Repo Have a Remote?
#' @return TRUE if the path has a remote url.
#' @param path_to_local_repo full path to local repository to be pushed
#' @export

hasRemote <-
        function(path_to_local_repo = NULL,
                 remote_name = "origin") {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)


                x <- remote_url(path_to_local_repo = path_to_local_repo,
                           remote_name = remote_name)

                if (length(x) == 0) {

                        FALSE

                } else {
                        TRUE
                }
        }





#' Is the path a git repo?
#' @return TRUE if the path has an initialized .git.
#' @param path_to_local_repo full path to local repository to be pushed
#' @export

isRepo <-
        function(path_to_local_repo = NULL) {

                if (is.null(path_to_local_repo)) {

                        path_to_local_repo <- getwd()

                }

                stop_if_dir_not_exist(path_to_local_repo = path_to_local_repo)

                x <- suppressWarnings(system(paste0("cd\n",
                       "cd ", path_to_local_repo,"\n",
                       "git status"),
                       ignore.stderr = TRUE,
                       intern = TRUE
                ))

                if (length(x) == 0) {

                        FALSE

                } else {
                        TRUE
                }
        }







#' Is The Repository Up-To-Date?
#' @param path_to_local_repo path to local repo
#' @export

isUpToDate <-
        function(path_to_local_repo = NULL) {
                git_msg <- pull(path_to_local_repo = path_to_local_repo,
                                verbose = FALSE)
                if ("Already up to date." %in% git_msg) {
                       TRUE
                } else {
                       FALSE
                }
        }





#' Check whether a commit is needed or not for a given repo
#' @param path_to_local_repo path to the local repo
#' @importFrom secretary typewrite
#' @export

isWorkingTreeClean <-
        function(path_to_local_repo = NULL) {


                gitMessage <- status(path_to_local_repo = path_to_local_repo,
                            verbose = FALSE)

                if ("nothing to commit, working tree clean" %in% gitMessage) {
                       TRUE
                } else {
                       FALSE
                }
        }





