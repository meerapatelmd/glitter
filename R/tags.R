#' @title List Tags
#' @seealso
#'  \code{\link[git2r]{tags}}
#' @rdname list_tags
#' @export
#' @importFrom git2r tags

list_tags <-
        function(path = getwd()) {

                git2r::tags(repo = path)



        }
