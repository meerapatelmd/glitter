#' @title List Tags
#' @description
#' `git2r::tags()` ordered by date.
#' @seealso
#'  \code{\link[git2r]{tags}}
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
