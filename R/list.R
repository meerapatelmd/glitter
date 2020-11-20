





list_big_files <-
        function(mb_threshold = 50, path_to_local_repo = getwd()) {

                cave::get_mb_size(list.files(path = path_to_local_repo,
                                            full.names = TRUE,
                                            recursive = TRUE)) %>%
                        dplyr::filter(mb >= 50) %>%
                        dplyr::select(file) %>%
                        unlist() %>%
                        unique()

        }
