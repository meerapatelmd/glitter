#' Does the GitHub Repo Have a Remote?
#' @return TRUE if the path has a remote url.
#' @param path full path to local repository to be pushed
#' @export

hasRemote <-
        function(path = getwd(),
                 remote = "origin") {

                x <- remote_url(path = path,
                           remote = remote)

                if (length(x) == 0) {

                        FALSE

                } else {
                        TRUE
                }
        }





#' Is the path a git repo?
#' @return TRUE if the path has an initialized .git.
#' @param path full path to local repository to be pushed
#' @export

isRepo <-
        function(path = getwd()) {

                x <- suppressWarnings(system(paste0("cd\n",
                       "cd ", path,"\n",
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
#' @param path path to local repo
#' @export

isUpToDate <-
        function(path = getwd()) {

                git_msg <- pull(path = path,
                                verbose = FALSE)
                if ("Already up to date." %in% git_msg) {
                       TRUE
                } else {
                       FALSE
                }
        }





#' Check whether a commit is needed or not for a given repo
#' @param path path to the local repo
#' @importFrom secretary typewrite
#' @export

isWorkingTreeClean <-
        function(path = getwd()) {


                gitMessage <- status(path = path,
                            verbose = FALSE)

                if ("nothing to commit, working tree clean" %in% gitMessage) {
                       TRUE
                } else {
                       FALSE
                }
        }





