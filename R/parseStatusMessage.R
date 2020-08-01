#' Parse Status Message
#'@description This function parses the status message returned as a vector when calling the status() function
#'@return A list of vectors that has split on the following headers: "On branch","Changes to be committed:", "Changes not staged for commit:", "Untracked files:" with headers removed.
#'@importFrom magrittr %>%
#'@importFrom purrr map
#'@importFrom purrr map2
#'@importFrom purrr keep
#'@importFrom rubix map_names_set


parseStatusMessage <-
        function(statusMessage) {


                # Subset core sections in the status message instance
                sections <-
                        #Core Sections
                        c("On branch",
                          "Changes to be committed:",
                          "Changes not staged for commit:",
                          "Untracked files:") %>%
                                                purrr::keep(~any(grepl(., statusMessage))) %>%
                                                unlist()


                starting_indices <-
                sections %>%
                        rubix::map_names_set(function(x) grep(x, statusMessage)) %>%
                        unlist()

                ending_indices <-
                        c(starting_indices[2:length(starting_indices)], length(statusMessage)) %>%
                        purrr::map(~.-1) %>%
                        unlist()

                starting_indices %>%
                        purrr::map2(ending_indices,
                                    function(x,y) statusMessage[x:y]) %>%
                        purrr::map(~.[!(. %in% c("",
                                                 sections,
                                                 "  (use \"git reset HEAD <file>...\" to unstage)",
                                                 "  (use \"git add <file>...\" to update what will be committed)",
                                                 "  (use \"git add/rm <file>...\" to update what will be committed)",
                                                 "  (use \"git checkout -- <file>...\" to discard changes in working directory)",
                                                 "  (use \"git add <file>...\" to include in what will be committed)"))])


        }
