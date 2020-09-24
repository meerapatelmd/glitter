




mk_gitignore_path <-
        function(path_to_local_repo = NULL) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                extend_path(path_to_local_repo,
                               ".gitignore")

        }



read_gitignore <-
        function(path_to_local_repo = NULL) {

               gitignore_path <- mk_gitignore_path(path_to_local_repo = path_to_local_repo)

               readLines(con = gitignore_path)
        }


write_gitignore <-
        function(...,
                 path_to_local_repo = NULL,
                 append = FALSE) {

                Args <- unlist(list(...))

                gitignore_path <- mk_gitignore_path(path_to_local_repo = path_to_local_repo)

                cat(Args, sep = "\n", file = gitignore_path, append = append)
        }


add_to_gitignore <-
        function(...,
                 path_to_local_repo = NULL) {

                write_gitignore(...,
                                path_to_local_repo = path_to_local_repo,
                                append = TRUE)

        }


rm_from_gitignore <-
        function(...,
                 path_to_local_repo = NULL) {

                Args <- unlist(list(...))

                gitignore <- read_gitignore()

                gitignore <- gitignore[!(gitignore %in% Args)]

                gitignore_path <- mk_gitignore_path(path_to_local_repo = path_to_local_repo)

                cat(gitignore, sep = "\n", file = gitignore_path)
        }



add_commit_gitignore <-
        function(path_to_local_repo = NULL) {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)




        }

