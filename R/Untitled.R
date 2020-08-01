# fns <- list.files("R", full.names = TRUE)
#
# for (file in fns) {
#         lins <- readr::read_lines(file)
#         if (any(grepl("list2", lins))) {
#                 print(file)
#                 secretary::press_enter()
#         }
# }
