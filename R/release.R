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
#'  \code{\link[usethis]{use_news_md}},\code{\link[usethis]{ui}}
#'  \code{\link[xfun]{read_utf8}}
#'  \code{\link[rlang]{seq2}}
#' @rdname read_news
#' @export 
#' @importFrom usethis use_news_md ui_stop
#' @importFrom xfun read_utf8
#' @importFrom rlang seq2
read_news <- function(path = getwd()) {

        news_md <- file.path(path, "NEWS.md")
        if (!file.exists(news_md)) {

                usethis::use_news_md(open = FALSE)

        }

        lines    <- xfun::read_utf8(news_md)
        headings <- which(grepl("^#\\s+", lines))

        if (length(headings) == 0) {
                usethis::ui_stop("No top-level headings found in {usethis::ui_value('NEWS.md')}")

        }



        if (length(headings) == 1) {
                news <- lines[rlang::seq2(headings + 1, length(lines))]

                # Remove leading and trailing empty lines
                text <- which(news != "")
                if (length(text) == 0) {
                        return("")
                }

                news <- news[text[[1]]:text[[length(text)]]]

                output <-
                list(
                list(Version =
                             lines[headings[1]],
                     Contents =
                             news))

                names(output)[1] <- lines[headings[1]]

        } else {

                output <- list()
                for (i in 2:length(headings)) {

                        news <- lines[rlang::seq2(headings[[i-1]] + 1, headings[[i]] - 1)]

                        text <- which(news != "")

                        if (length(text)>0) {
                        news2 <- news[text[1]:text[length(text)]]

                        output[[length(output)+1]] <-
                                list(Version =
                                             lines[headings[[i-1]]],
                                     Contents = news2)

                        names(output)[length(output)] <-
                                lines[[headings[[i-1]]]]

                        } else {

                                output[[length(output)+1]] <-
                                        list(Version =
                                                     lines[headings[[i-1]]],
                                             Contents = "")

                                names(output)[length(output)] <-
                                        lines[[headings[[i-1]]]]

                        }

                }

                return(output)


        }

}



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
#' @rdname read_latest_news
#' @export 
read_latest_news <- function(path = getwd()) {

        all_news <-
                read_news(path  = path)

        all_news[[1]]
}



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
#'  \code{\link[desc]{description}}
#' @rdname read_description
#' @export 
#' @importFrom desc description
read_description <-
        function(path = getwd()) {

                desc <- desc::description$new(path)
                as.list(desc$get(desc$fields()))

        }

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
#' @rdname read_latest_desc_version
#' @export 
read_latest_desc_version <-
        function(path = getwd()) {

                read_description(path = path)$Version

        }



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
#' @rdname get_tags
#' @export 
#' @importFrom git2r tags
get_tags <-
        function(path = getwd()) {


        input <-
                git2r::tags(repo = path)


        tags <- names(input)
        tag_date <- vector()

        for (tag in tags) {

                tag_input <- input[[tag]]

                tag_date <-
                        c(tag_date,
                as.Date(as.character(tag_input$author$when)))




        }

        names(tag_date) <- tags


        input[names(sort(tag_date))]
        }


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
#' @rdname get_latest_tag
#' @export 
get_latest_tag <-
        function(path = getwd()) {

                tags <- get_tags(path = path)
                names(tags)[length(tags)]

        }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname validate_versions
#' @export 
validate_versions <-
        function() {

                list(
                "Tag" = get_latest_tag(),
                "DESCRIPTION" = read_latest_desc_version(),
                "NEWS.md" = read_latest_news()$Version)

        }
