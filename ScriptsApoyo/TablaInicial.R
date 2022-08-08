tab_inicial <- read_excel("ArchivosApoyo/titular.xlsx")

tab_inicial[1, 2] <- str_to_title(unique(verificaciones$EstablecimientoNombre))
tab_inicial[2, 2] <- as.character(unique(verificaciones$EstablecimientoRetc))
tab_inicial[3, 2] <- str_replace(texto_tabla_resoluciones, "NA ", "")
tab_inicial[4, 2] <- texto_tabla_norma
tab_inicial[5, 2] <- paste(diccionario_mes[as.numeric(params$Mes), 2], as.numeric(params$Anio))
tab_inicial[6, 2] <- as.character(nrow(lista_ductos))
tab_inicial[7, 2] <- as.character(format(Sys.Date(), "%d-%m-%Y"))
tab_inicial[8, 2] <- as.character(format(as_date(unique(str_sub(verificaciones_todo$FechaVerificacion, 1, 10))), "%d-%m-%Y"))

tab_inicial_formato <- tab_inicial %>% 
  rename(
    " " = "a",
    "  " = "b"
  ) %>% 
  flextable() %>% 
  bg(bg = "#00366c", part = "header") %>% 
  font(font = "Source Sans Pro", part = "all") %>% 
  fontsize(size = 11, part = "header") %>% 
  color(color = "#003366") %>% 
  bold(j = 1) %>% 
  width(j = c(1,2), width = c(2.5,5))