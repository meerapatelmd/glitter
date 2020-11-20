#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param all PARAM_DESCRIPTION, Default: FALSE
#' @param path PARAM_DESCRIPTION, Default: NULL
#' @param max_mb PARAM_DESCRIPTION, Default: 50
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[tibble]{tibble}}
#'  \code{\link[dplyr]{filter}},\code{\link[dplyr]{select}}
#'  \code{\link[purrr]{map}}
#' @rdname add
#' @export
#' @importFrom tibble tibble
#' @importFrom dplyr filter select
#' @importFrom purrr map


add <-
        function(...,
                 path = getwd(),
                 pattern = NULL,
                 all.files = FALSE,
                 recursive = FALSE,
                 ignore.case = FALSE,
                 include.dirs = FALSE,
                 no.. = FALSE,
                 max_mb = 50) {


                path <- normalizePath(path.expand(path = path), mustWork = TRUE)
                path_to_root <- root(path = path)

                cli::cat_line()
                status(path = path)

                big_files <- list_big_files(mb_threshold = max_mb)
                if (length(big_files)) {

                        cli::cat_rule(secretary::magentaTxt(sprintf("Files Greater Than %s MB", max_mb)))
                        cli::cat_bullet(big_files,
                                        bullet = "line")

                        secretary::press_enter()

                }

                if (!missing(...)) {

                        files_to_add <- rlang::list2(...)
                        files_to_add <- file.path(path, unlist(files_to_add))

                } else {

                        files_to_add <-
                                list.files(path = path,
                                           pattern = pattern,
                                           all.files = all.files,
                                           full.names = TRUE,
                                           recursive = recursive,
                                           ignore.case = ignore.case,
                                           include.dirs = include.dirs,
                                           no.. = no..)


                }

                command <-
                        c(starting_command(path = path_to_root),
                          files_to_add %>%
                                  purrr::map(~ sprintf("git add %s", .)) %>%
                                  unlist()) %>%
                        paste(collapse = "\n")

                system(command = command,
                       intern = TRUE)


                # status(path = path,
                #        header = "Updated Status Response")

        }
