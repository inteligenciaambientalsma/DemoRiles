n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
  assign(paste0("superacion_", n), datos_superacion %>% 
           filter(DuctoId == d) %>% 
           distinct(GlosaParametro) %>% 
           pull(GlosaParametro) %>% unique())
  
  for (i in get(paste0("superacion_", n))){
    assign(paste0("superacion_", n, "_", i), paste("-", i))
  }
  
  assign(paste0("superacion_", n, "texto"), map_chr(ls()[str_detect(ls(), paste0("superacion_", n, "_"))], get) %>% 
           paste(collapse = "\n") %>% 
           paste("El establecimiento registra superaciones en los siguientes parámetros:\n\n", .)
  )
  
  n <- n + 1
}