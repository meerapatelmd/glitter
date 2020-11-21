#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param permanently_remove filename of the file to permanently remove all traces of
#' @importFrom typewriteR tell_me
#' @importFrom crayon red
#' @export


destroy <-
        function(path_to_local_repo, permanently_remove_this_file) {

                typewriteR::tell_me(crayon::red("\tWARNING: Are you sure you want to destroy all traces of", path_to_local_repo, "in this repo? Changes are not reversible."))
                typewriteR::stop_and_enter()

                x <-
                system(paste0("git filter-branch --index-filter 'git rm --cached --ignore-unmatch ", permanently_remove_this_file, "' HEAD"), intern = TRUE)

                return(x)
        }
