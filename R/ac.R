#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param all PARAM_DESCRIPTION, Default: FALSE
#' @param commit_msg PARAM_DESCRIPTION
#' @param path_to_local_repo PARAM_DESCRIPTION, Default: NULL
#' @param verbose PARAM_DESCRIPTION, Default: TRUE
#' @param max_mb PARAM_DESCRIPTION, Default: 50
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ac
#' @export

ac <-
        function(...,
                 all = FALSE,
                 commit_msg,
                 path_to_local_repo = NULL,
                 verbose = TRUE,
                 max_mb = 50)

                {

                mk_local_path_if_null(path_to_local_repo = path_to_local_repo)

                add(...,
                    all = all,
                    path_to_local_repo = path_to_local_repo,
                    max_mb = max_mb)


                com(commit_msg = commit_msg,
                    path_to_local_repo = path_to_local_repo,
                    verbose = verbose)


        }
