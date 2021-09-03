
#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: getwd()
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[git2r]{tags}}
#'  \code{\link[purrr]{map}}
#'  \code{\link[tibble]{as_tibble}}
#'  \code{\link[dplyr]{bind}},\code{\link[dplyr]{arrange}},\code{\link[dplyr]{desc}},\code{\link[dplyr]{mutate_all}},\code{\link[dplyr]{vars}}
#' @rdname list_tags
#' @export 
#' @importFrom git2r tags
#' @importFrom purrr map
#' @importFrom tibble as_tibble_col
#' @importFrom dplyr bind_rows arrange desc mutate_at vars
list_tags <-
        function(path = getwd()) {

                name_order <-
                git2r::tags(repo = path) %>%
                        purrr::map(
                                function(x)
                                        tibble::as_tibble_col(as.POSIXct(x$author$when),
                                                              "tag_datetime")) %>%
                        dplyr::bind_rows(.id = "tag") %>%
                        dplyr::arrange(dplyr::desc(tag_datetime)) %>%
                        dplyr::mutate_at(dplyr::vars(tag), factor, levels = .$tag) %>%
                        split(.$tag) %>%
                        names()


                git2r::tags(repo = path)[name_order]



        }





#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: getwd()
#' @param tag PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[git2r]{tag_delete}}
#' @rdname delete_local_tag
#' @export 
#' @importFrom git2r tag_delete
delete_local_tag <-
        function(path = getwd(),
                 tag) {

                git2r::tag_delete(object = path,
                                  name   = tag)
        }



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param path PARAM_DESCRIPTION, Default: getwd()
#' @param tag PARAM_DESCRIPTION
#' @param remote_name PARAM_DESCRIPTION, Default: 'origin'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[glue]{glue}}
#' @rdname delete_remote_tag
#' @export 
#' @importFrom glue glue
delete_remote_tag <-
        function(path = getwd(),
                 tag,
                 remote_name = 'origin') {

                command <-
                as.character(
                        glue::glue(
                                "cd",
                                "cd {path}",
                                "git push --delete {remote_name} {tag}",
                                .sep = "\n"
                        )
                )

                system(command = command)


        }
