#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param all PARAM_DESCRIPTION, Default: FALSE
#' @param path_to_local_repo PARAM_DESCRIPTION, Default: NULL
#' @param max_mb PARAM_DESCRIPTION, Default: 50
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[tibble]{tibble}}
#'  \code{\link[dplyr]{filter}},\code{\link[dplyr]{select}}
#'  \code{\link[purrr]{map}}
#' @rdname add
#' @export
#' @importFrom tibble tibble
#' @importFrom dplyr filter select
#' @importFrom purrr map


add <-
        function(...,
                 all = TRUE,
                 path_to_local_repo = NULL,
                 max_mb = 50) {


                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                secretary::typewrite_bold(secretary::magentaTxt("\n  Before:"))
                status(path_to_local_repo = path_to_local_repo)

                if (all) {


                        files <-
                                list.files(path_to_local_repo,
                                           recursive = TRUE,
                                           all.files = TRUE)

                        file_mb <- file.info(files)$size/(10^6)

                        big_files <-
                                tibble::tibble(files = files,
                                               file_mb = file_mb) %>%
                                dplyr::filter(file_mb >= max_mb) %>%
                                dplyr::select(files) %>%
                                unlist() %>%
                                unname()

                        if (length(big_files)) {

                                files <- files[!(files %in% big_files)]

                                command <-
                                        c(starting_command(path_to_local_repo = path_to_local_repo),
                                          files %>%
                                                  purrr::map(~paste0("git add ", .)) %>%
                                                  unlist()) %>%
                                        paste(collapse = "\n")

                                system(command = command)


                        } else {


                                command <-
                                        c(starting_command(path_to_local_repo = path_to_local_repo),
                                          "git add .") %>%
                                        paste(collapse = "\n")


                                system(command = command)

                        }


                } else {

                Args <- unlist(list(...))
                Args <- paste(Args, collapse = "|")

                #print(Args)

                files <-
                list.files(path_to_local_repo,
                           pattern = Args,
                           recursive = TRUE,
                           all.files = TRUE)


                file_mb <- file.info(files)$size/(10^6)

                files <-
                        tibble::tibble(files = files,
                                       file_mb = file_mb) %>%
                        dplyr::filter(file_mb < max_mb) %>%
                        dplyr::select(files) %>%
                        unlist() %>%
                        unname()


                command <-
                        c(starting_command(path_to_local_repo = path_to_local_repo),
                          files %>%
                                  purrr::map(~paste0("git add ", .)) %>%
                                  unlist()) %>%
                        paste(collapse = "\n")

                system(command = command)

                }

                secretary::typewrite_bold(secretary::magentaTxt("  After:"))
                status(path_to_local_repo = path_to_local_repo)

        }
