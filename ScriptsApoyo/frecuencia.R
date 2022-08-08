
n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
  assign(paste0("frecuencia_", n), datos_frecuencia %>% 
    filter(DuctoId == d) %>% 
    distinct(GlosaParametro) %>% 
    pull(GlosaParametro) %>% unique())
  
  for (i in get(paste0("frecuencia_", n))){
    assign(paste0("frecuencia_", n, "_", i), paste("-", i))
  }
  
  exigencias <- datos_frecuencia %>% 
    filter(DuctoId == d) %>%
    distinct(GlosaParametro, FrecuenciaExigida) %>% 
    mutate(Texto = paste0("- ", GlosaParametro, ": ", FrecuenciaExigida)) %>% 
    pull(Texto) %>% 
    paste(collapse = "\n")
  
  assign(paste0("frecuencia_", n, "texto"), map_chr(ls()[str_detect(ls(), paste0("frecuencia_", n, "_"))], get) %>% 
    paste(collapse = "\n") %>% 
    paste("El establecimiento registra incumplimientos en la frecuencia de monitoreos de los siguientes parámetros:\n\n", .) %>% 
    paste0(., "\n\n", "Recuerde que según su RPM la frecuencia de monitoreo de los parámetros incumplidos es:\n", exigencias))
  
  n <- n + 1
}


