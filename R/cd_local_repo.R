#' Change directory to local repo
#' @export

cd_local_repo <-
        function(path_to_local_repo) {

                system("cd\n")
                system(paste0("cd ", path_to_local_repo,"\n"))

        }
