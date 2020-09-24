







add <-
        function(...,
                 path_to_local_repo = NULL,
                 max_mb = 50) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                Args <- unlist(list(...))
                Args <- paste(Args, collapse = "|")


                files <-
                list.files(path_to_local_repo,
                           pattern = Args,
                           recursive = TRUE)


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
