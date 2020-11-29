library(easyBakeOven)

activateGoogleFont(name = "Pacifico")

createMedallion(sourceImg = "logo.jpg",
                package = "glitter",
                s_width = 1.5,
                s_height = 1.5,
                s_y = 1,
                spotlight = TRUE,
                l_y = 1.4,
                l_width = 4,
                l_height = 4,
                l_alpha = 0.8,
                p_family = "Pacifico",
                p_size = 13,
                p_color = "#000000",
                h_color = "#000000")


createFavicons(overwrite = TRUE)
