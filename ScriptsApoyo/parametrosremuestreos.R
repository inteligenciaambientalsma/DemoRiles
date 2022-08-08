n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
  assign(paste0("parametroremuestreo_", n), datos_parametros_remuestreos %>% 
           filter(DuctoId == d) %>% 
           distinct(GlosaParametro) %>% 
           pull(GlosaParametro) %>% unique())
  
  for (i in get(paste0("parametroremuestreo_", n))){
    assign(paste0("parametroremuestreo_", n, "_", i), paste("-", i))
  }
  
  assign(paste0("parametroremuestreo_", n, "texto"), map_chr(ls()[str_detect(ls(), paste0("parametroremuestreo_", n, "_"))], get) %>% 
           paste(collapse = "\n") %>% 
           paste("El establecimiento no reporta remuestreo para los siguientes parámetros:\n\n", .) 
  )
  
  n <- n + 1
}