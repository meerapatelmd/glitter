#' @title
#' Is the cardinal branch called `main`?
#'
#' @rdname is_main
#' @export
is_main <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "main" %in% repo_branches
        }

#' @title
#' Is the cardinal branch called `master`?
#'
#' @rdname is_master
#' @export
is_master <-
        function(path = getwd()) {

                repo_branches <-
                        branch(verbose = FALSE,
                               path = path)


                "master" %in% repo_branches
        }



#' @title
#' Copy Branch
#'
#' @description
#' Copy an existing branch to a new branch with the provided
#' name. To rename default branches, such as  `main` to
#' `master`, this function is run followed by pointing the
#' repo to the new branch as the default before deleting the
#' original `main` branch with:
#' ```
#' git push origin --delete main
#' ```
#' See
#' \href{https://www.git-tower.com/learn/git/faq/git-rename-master-to-main/}{Git Tower FAQ: Rename Master to Main}
#' for full details.  .
#' @export

copy_branch <-
        function(path = getwd(),
                 branch,
                 new_branch_name,
                 remote_branch = "origin") {


        path <- normalizePath(
                  path.expand(path = path),
                  mustWork = TRUE)


        command <-
                c("cd",
                sprintf("cd %s", path),
                sprintf("git branch -m %s %s",
                        branch,
                        new_branch_name),
                sprintf("git push -u %s %s",
                        remote_branch,
                        new_branch_name)) %>%
                paste(collapse = "\n")

        system(command = command)




        }
