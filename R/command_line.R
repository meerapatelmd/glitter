



send_command <-
        function(command) {

                system(command = command,
                       intern = TRUE)

        }


sys_command <- purrr::quietly(send_command)
