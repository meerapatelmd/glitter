#' Push a local repo to remote MSK KMI Enterprise GitHub repository
#' @param large_file_extensions extensions of files that will be large and will need to be tracked using the lfs
#' @keywords internal
#' @export


lfs_install_this_repo <-
        function(large_file_extensions = c("xlsx", "csv", "RData")) {
                system("git lfs install")
                cat("\n")
                large_file_extensions %>%
                        purrr::map(function(x) system(paste0("git lfs track '*.", x,"'")))

                cat("\n")
                system("git add .gitattributes")
                cat("\n")
                system("git commit -m '+: .gitattribute for lfs tracking'")
        }
