#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param permanently_remove filename of the file to permanently remove all traces of
#' @importFrom mirCat typewrite
#' @importFrom crayon red
#' @export


destroy <-
        function(path_to_local_repo, destroy_this_file) {

                mirCat::typewrite(crayon::red("\tWARNING: Are you sure you want to destroy all traces of", path_to_local_repo, "in this repo? Changes are not reversible."))
                mirCat::stop_before_continue()

                path_to_file <- paste0(path_to_local_repo, "/", destroy_this_file)
                if (file.exists(path_to_file)) {
                        file.remove(path_to_file)
                }
                x <-
                        system(paste0("cd\n",
                                      "cd ", path_to_local_repo,"\n",
                                      "git add ."),
                               intern = TRUE
                        )

                x <-
                system(paste0("git filter-branch --index-filter 'git rm --cached --ignore-unmatch ", destroy_this_file, "' HEAD"), intern = TRUE)

                return(x)

                commit(path_to_local_repo = path_to_local_repo,
                       commit_message = paste0("destroy all traces of ", destroy_this_file))

                push(path_to_local_repo)
        }
