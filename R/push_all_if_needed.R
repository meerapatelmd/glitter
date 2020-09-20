#' @title
#' Push a Local Repo if a Change is detected
#' @description FUNCTION_DESCRIPTION
#' @param path_to_local_repo PARAM_DESCRIPTION, Default: NULL
#' @param commit_message PARAM_DESCRIPTION
#' @rdname push_all_if_needed
#' @export


push_all_if_needed <-
        function(path_to_local_repo = NULL,
                 commit_message) {

                if (is.null(path_to_local_repo)) {
                        path_to_local_repo <- getwd()
                }

                output <- isWorkingTreeClean(path_to_local_repo = path_to_local_repo)

                if (!output) {
                        add_commit_all(commit_message = "automated push",
                                                path_to_local_repo = path_to_local_repo)
                        push(path_to_local_repo = path_to_local_repo)
                }
        }
