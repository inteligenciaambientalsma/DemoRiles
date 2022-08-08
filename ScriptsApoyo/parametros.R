n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
  assign(paste0("parametro_", n), datos_parametros %>% 
           filter(DuctoId == d) %>% 
           distinct(GlosaParametro) %>% 
           pull(GlosaParametro) %>% unique())
  
  for (i in get(paste0("parametro_", n))){
    assign(paste0("parametro_", n, "_", i), paste("-", i))
  }
  
  assign(paste0("parametro_", n, "texto"), map_chr(ls()[str_detect(ls(), paste0("parametro_", n, "_"))], get) %>% 
           paste(collapse = "\n") %>% 
           paste("El establecimiento no reporta resultados para los siguientes parámetros:\n\n", .) %>% 
           paste0(., "\n\n", "Recuerde que usted debe reportar mensualmente todos los parámetros indicados en su RPM.")
         )
  
  n <- n + 1
}

#parametros_p <- datos_parametros %>% 
#  distinct(Parametro, Año, Mes) %>% 
#  left_join(diccionario_mes) %>% 
#  arrange(Año, Mes) %>% 
#  group_by(Parametro, Año) %>% 
#  summarise(Meses = paste(unique(Nombre_mes), collapse = ", ")) %>% 
#  pull(Parametro) %>% unique()
#
#for (i in parametros_p){
#  
#  assign(paste0("parametro", "_", i), datos_parametros %>% 
#           filter(Parametro == i) %>% 
#           distinct(Parametro, Año, Mes) %>% 
#           left_join(diccionario_mes) %>% 
#           arrange(Año, Mes) %>% 
#           group_by(Parametro, Año) %>% 
#           summarise(Meses = paste(unique(Nombre_mes), collapse = ", "))  %>% 
#           ungroup() %>% 
#           mutate(texto = paste0(Año, ": ", Meses)) %>% 
#           pull(texto) %>% 
#           paste(collapse = " / ") %>% 
#           paste("-", i, "=", .))
#  
#}
#
#parametros_texto <- map_chr(ls()[str_detect(ls(), "parametro_")], get) %>% 
#  paste(collapse = "\n") %>% 
#  paste("El establecimiento no reporta parámetros en los siguientes períodos:\n\n", .)
#
#rm(i, mes, num)