#' @title
#' Delete a Remote Branch
#' @description
#' Delete a remote branch of a given local clone of a repo.
#' @param remote_branch Remote branch.
#' @rdname delete_remote_branch
#' @export


delete_remote_branch <-
        function(path = getwd(),
                 remote_branch) {

                if (missing(remote_branch)) {stop("'remote_branch' is missing.")}

                system(command = sprintf("git push origin --delete %s", remote_branch))

        }
