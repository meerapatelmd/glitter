









commit_on_close <-
        function(path_to_local_repo = getwd()) {

                if (isRepo(path_to_local_repo = path_to_local_repo)) {

                        if (!isWorkingTreeClean(path_to_local_repo = path_to_local_repo)) {

                                status()

                                cli::cat_line()
                                cli::cat_rule(secretary::magentaTxt("Review Commit"))
                                ans <- readline("Commit all changes before exit? Y/n: ")

                                if (substr(ans, 1, 1) == "Y") {

                                        commit_message <- readline("What is the commit message? ")

                                        if (commit_message != "") {


                                                add_commit_all(commit_message = commit_message,
                                                                        description = description,
                                                                        verbose = TRUE)

                                                ans <- readline("Push to origin/master now? Y/n: ")
                                                if ((substr(ans, 1, 1) == "Y")) {
                                                        push()
                                                }
                                        }
                                }
                        }
                }
        }
