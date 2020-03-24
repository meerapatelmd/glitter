#'Add files greater than indicated size in working directory to .gitignore
#'@param max_size_in_gb files sized greater than this in gigabytes will be ignored in git
#'@return updated .gitignore in local repository that is pushed to master origin
#'@import dplyr
#'@import purrr
#'@export
#'

ignore_lfs_in_this_repo <-
        function(max_size_in_gb = 1.8) {
                dplyr::tibble(filename = list.files(recursive = TRUE, full.names = TRUE)) %>%
                        dplyr::mutate(gbs = mirCat::size_in_gigabytes(filename)) %>%
                        dplyr::filter(gbs > max_size_in_gb) %>%
                        dplyr::select(filename) %>%
                        unlist() %>%
                        purrr::map(function(x) cat(x, file = ".gitignore", sep = "\n", append = TRUE))

                return_msg_01 <- system("git add .gitignore", intern = TRUE)
                cat("\n")

                return_msg_02 <-
                        system(paste0("git commit -m '=: add any file greater than ", max_size_in_gb, " gbs to .gitignore"), intern = TRUE)
                cat("\n")
                return_msg_03 <- git_push_this_repo()
                cat("\n")

                return(paste(return_msg_01, return_msg_02, return_msg_03, sep = "\n"))
        }
