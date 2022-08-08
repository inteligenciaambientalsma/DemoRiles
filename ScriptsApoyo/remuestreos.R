n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
  assign(paste0("remuestreo_texto", n), datos_remuestreos %>% 
           filter(DuctoId == d))
  
  assign(paste0("remuestreo_noaplica", n), 
         ifelse(unique(pull(filter(verificaciones, DuctoId == d), PresentaRemuestra)) == "NO APLICA", 
                "SI", 
                "NO")
  )
  
  n <- n + 1
}

#n <- 1
#for (d in ductos){
#  
#  assign(paste0("parametro_", n), datos_parametros %>% 
#           filter(Punto_Descarga == d) %>% 
#           distinct(Parametro) %>% 
#           pull(Parametro) %>% unique())
#  
#  for (i in get(paste0("parametro_", n))){
#    assign(paste0("parametro_", n, "_", i), paste("-", i))
#  }
#  
#  assign(paste0("parametro_", n, "texto"), map_chr(ls()[str_detect(ls(), paste0("parametro_", n, "_"))], get) %>% 
#           paste(collapse = "\n") %>% 
#           paste("El establecimiento no reporta resultados para los siguientes parámetros:\n\n", .) %>% 
#           paste(., "\n\n", "Recuerde que usted debe reportar mensualmente todos los parámetros indicados en su RPM. Tenga presente que en el mes XXXX debe reportar al menos 1 muestra que considere todos los parámetros de control establecidos en la Tabla XX del DS.XXX.")
#  )
#  
#  n <- n + 1
#}
#

#parametros_r <- datos_remuestreos %>% 
#  distinct(Parametro, Año, Mes) %>% 
#  left_join(diccionario_mes) %>% 
#  arrange(Año, Mes) %>% 
#  group_by(Parametro, Año) %>% 
#  summarise(Meses = paste(unique(Nombre_mes), collapse = ", ")) %>% 
#  pull(Parametro) %>% unique()
#
#for (i in parametros_r){
#  
#  assign(paste0("remuestreo", "_", i), datos_remuestreos %>% 
#           filter(Parametro == i) %>% 
#           distinct(Parametro, Año, Mes) %>% 
#           left_join(diccionario_mes) %>% 
#           arrange(Año, Mes) %>% 
#           group_by(Parametro, Año) %>% 
#           summarise(Meses = paste(unique(Nombre_mes), collapse = ", ")) %>% 
#           ungroup() %>% 
#           mutate(texto = paste0(Año, ": ", Meses)) %>% 
#           pull(texto) %>% 
#           paste(collapse = " / ") %>% 
#           paste("-", i, "=", .))
#  
#}
#
#remuestreos_texto <- map_chr(ls()[str_detect(ls(), "remuestreo_")], get) %>% 
#  paste(collapse = "\n") %>% 
#  paste("El establecimiento no informa remuestreo de parámetros con superación en los siguientes períodos:\n\n", .)
#
#rm(i, mes, num)
#