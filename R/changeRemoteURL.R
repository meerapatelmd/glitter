#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path_to_local_repo PARAM_DESCRIPTION
#' @param pattern PARAM_DESCRIPTION
#' @param replacement PARAM_DESCRIPTION
#' @param remote PARAM_DESCRIPTION, Default: 'origin'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[glitter]{remote_url}}
#'  \code{\link[stringr]{str_replace}}
#' @rdname changeRemoteURL
#' @export
#' @importFrom stringr str_replace

changeRemoteURL <-
        function(path_to_local_repo,
                 pattern,
                 replacement,
                 remote = "origin") {

                old_remote_url <- remote_url(path_to_local_repo = path_to_local_repo)
                new_remote_url <- stringr::str_replace(old_remote_url,
                                                       pattern = pattern,
                                                       replacement = replacement)


                command <-
                        c("cd",
                          paste0("cd ", old_remote),
                          paste0("git remote remove ", remote),
                          paste0("git remote add ", remove, " ", new_remote_url))

                system(command = paste(command, collapse = "\n"))
        }
