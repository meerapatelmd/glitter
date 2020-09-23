






get_repo_info <-
        function(github_username,
                 repo,
                 as_list = FALSE) {

                output <-
                        get_remote_repos(github_username = github_username) %>%
                        purrr::pluck("REPOS") %>%
                        rubix::filter_for(filter_col = name,
                                          inclusion_vector = repo)

                if (as_list) {
                        as.list(unlist(output))
                } else {
                        output
                }
        }
