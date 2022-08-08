imprimir_tabla_final <- function(x) {
  flextable(x) %>% 
    align(j = 1, align = "center") %>% 
    rotate(rotation = "btlr", j = 1, align = "center") %>% 
    bg(bg = "#00366c", part = "header") %>% # #003366
    color(color = "white", part = "header", j = (1:4)) %>% 
    bg(bg = "#E9E9E9", i = c(1, 3, 5)) %>% 
    bg(bg = "#F5F5F5", i = c(2, 4, 6)) %>% 
    bg(bg = "#00366c", i = c(1, 3, 5), j = 1) %>% 
    bg(bg = "#66B2FF", i = c(2, 4, 6), j = 1) %>% 
    color(color = "#003366") %>% 
    color(color = "white", i = c(1:6), j = 1) %>% 
    align(align = "left") %>% 
    align(align = "center", part = "header") %>% 
    fontsize(size = 14, part = "header") %>% 
    fontsize(size = 9, part = "body") %>% 
    fontsize(j = 1, size = 11, part = "body") %>% 
    font(font = "Source Sans Pro", part = "all") %>% 
    font(font = "Source Sans Pro", part = "body", j = c(2, 3)) %>% 
    color(~ CUMPLE == "SI", ~CUMPLE, color = "light green") %>% 
    color(~ CUMPLE == "NO", ~CUMPLE, color = "red") %>% 
    align(align = "center", j = c(1, 4)) %>% 
    fontsize(size = 20, part = "body", j = 4) %>% 
    bold(j = c(1, 2)) %>% 
    bold(i = 1, part = "header") %>% 
    width(j = c(1,2,3,4), width = c(0.4,2,4,1)) %>% 
    border(border = fp_border(color = "white", width = 1, style="solid")) %>% 
    border(border = fp_border(color = "#00366c", width = 1, style="solid"), part = "header") 
}