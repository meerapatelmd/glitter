# library(hexSticker)
# s <- sticker(~plot(cars, cex=.5, cex.axis=.5, mgp=c(0,.3,0), xlab="", ylab=""),
#              package="hexSticker", p_size=20, s_x=.8, s_y=.6, s_width=1.4, s_height=1.2,
#              filename= system.file("figures/baseplot.png", package = "hexSticker"))
#
# sticker("img/logo.jpg",
#         package="glitter",
#         filename="imgfile.png",
#         s_width = 2,
#         s_height = 2,
#         s_x = .5,
#         s_y = 1.0,
#         h_fill = "#000000",
#         h_color = "111111",
#         white_around_sticker=TRUE)
#
#
# %>%
#         geom_pkgname("glitter") %>%
#         save_sticker("test")
#
# cave::create_dir_if_not_exist("man/figures")
#
# mapply(file.copy,
#        from = list.files("pkgdown/favicon", full.names = TRUE),
#        to = paste0("man/figures/", basename(list.files("pkgdown/favicon", full.names = TRUE))))
#
#

# mapply(file.copy,
#        from = list.files("pkgdown/favicon", full.names = TRUE),
#        to = paste0("docs/", basename(list.files("pkgdown/favicon", full.names = TRUE))))
