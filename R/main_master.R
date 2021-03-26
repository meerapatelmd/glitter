




is_main <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "main" %in% repo_branches
        }





is_master <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "master" %in% repo_branches
        }
