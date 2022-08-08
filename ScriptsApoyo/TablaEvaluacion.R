tabla <- read_excel("ArchivosApoyo/contenido.xlsx") %>% 
  rename(" " = "nom")

lista_tablas <- list()
#i <- 1
for (i in 1:length(unique(verificaciones$DuctoId))){
  
  tabla_ducto <- tabla
  
  if (nrow(get(paste0("informar_texto", i))) > 0){ # NO INFORMA DESCARGA
    
    #######################
    # NO INFORMA DESCARGA #
    #######################
    
    tabla_ducto[1,3] <- "No ha  reportado el autocontrol del período evaluado."
    tabla_ducto[2,3] <- "Sin información para realizar evaluación."
    tabla_ducto[3,3] <- "Sin información para realizar evaluación."
    tabla_ducto[4,3] <- "Sin información para realizar evaluación."
    tabla_ducto[5,3] <- "Sin información para realizar evaluación."
    tabla_ducto[6,3] <- "Sin información para realizar evaluación."
    
    tabla_ducto <- tabla_ducto %>% 
      mutate(CUMPLE = case_when(
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "CUMPLE") ~ "SI",
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "Sin información") ~ "-",
        TRUE ~ "NO"))
    
  } else if (get(paste0("informar_informanodescarga", i)) == "SI") { # INFORMA NO DESCARGA
    
    #######################
    # INFORMA NO DESCARGA #
    #######################
    
    tabla_ducto[2,3] <- "Sin descarga durante el período"
    tabla_ducto[3,3] <- "Sin descarga durante el período"
    tabla_ducto[4,3] <- "Sin descarga durante el período"
    tabla_ducto[5,3] <- "Sin descarga durante el período"
    tabla_ducto[6,3] <- "Sin descarga durante el período"
    
    tabla_ducto <- tabla_ducto %>% 
      mutate(CUMPLE = case_when(
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "CUMPLE") ~ "SI",
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "Sin descarga") ~ "-",
        TRUE ~ "NO"))    
    
  } else if (nrow(get(paste0("remuestreo_texto", i))) > 0) { # INFORMA DESCARGA PERO NO HA REPORTADO REMUESTREO
    
    #########################
    # NO REPORTA REMUESTREO #
    #########################
    
    # PARAMETRO
    if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[2,3] <- get(paste0("parametro_", i, "texto"))
    } 
    
    # FRECUENCIA
    if (length(get(paste0("frecuencia_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste(get(paste0("frecuencia_", i, "texto")), "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[3,3] <- get(paste0("frecuencia_", i, "texto"))
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    }
    
    # REMUESTREO
    tabla_ducto[4,3] <- "En espera de remuestreo."
    
    # PARAMETRO REMUESTREO
    tabla_ducto[5,3] <- "Sin información para realizar evaluación."
    
    # SUPERACION
    if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0){
      tabla_ducto[6,3] <- get(paste0("superacion_", i, "texto"))  
    } else if (length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    }
    
    tabla_ducto <- tabla_ducto %>% 
      mutate(CUMPLE = case_when(
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "CUMPLE") ~ "SI",
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "En espera de") ~ "-",
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "Sin información para") ~ "-",
        TRUE ~ "NO"))
    
  } else if (get(paste0("remuestreo_noaplica", i)) == "SI") { # INFORMA DESCARGA Y REMUESTREO NO APLICA
    
    ########################
    # REMUESTREO NO APLICA #
    ########################
    
    # PARAMETRO
    if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[2,3] <- get(paste0("parametro_", i, "texto"))
    } 
    
    # FRECUENCIA
    if (length(get(paste0("frecuencia_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste(get(paste0("frecuencia_", i, "texto")), "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[3,3] <- get(paste0("frecuencia_", i, "texto"))
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    }
    
    # REMUESTREO
    tabla_ducto[4,3] <- "No aplica por no haber superación de parámetros."
    
    # PARAMETRO REMUESTREO
    tabla_ducto[5,3] <- "No aplica por no requerirse remuestreo."
    
    ## SUPERACION
    #if (length(get(paste0("superacion_", i))) > 0){
    #tabla_ducto[6,3] <- get(paste0("superacion_", i, "texto"))
    #}
    
    # SUPERACION
    if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0){
      tabla_ducto[6,3] <- get(paste0("superacion_", i, "texto"))  
    } else if (length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    }
    
    tabla_ducto <- tabla_ducto %>% 
      mutate(CUMPLE = case_when(
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "CUMPLE") ~ "SI",
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "No aplica") ~ "-",
        TRUE ~ "NO"))
    
  } else {  # INFORMA Y SE EVALUA TODO
    
    ################
    # EVALUAR TODO #
    ################
    
    # PARAMETRO
    if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[2,3] <- get(paste0("parametro_", i, "texto"))
    } 
    
    # FRECUENCIA
    if (length(get(paste0("frecuencia_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste(get(paste0("frecuencia_", i, "texto")), "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[3,3] <- get(paste0("frecuencia_", i, "texto"))
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[3,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    }
    
    # PARAMETRO REMUESTREO
    if (length(get(paste0("parametroremuestreo_", i))) > 0){
      tabla_ducto[5,3] <- get(paste0("parametroremuestreo_", i, "texto"))
    }
    
    # SUPERACION
    if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros no reportados).")
    } else if (length(get(paste0("superacion_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0(get(paste0("superacion_", i, "texto")), "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    } else if (length(get(paste0("superacion_", i))) > 0){
      tabla_ducto[6,3] <- get(paste0("superacion_", i, "texto"))  
    } else if (length(get(paste0("parametro_", i))) > 0 & length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros no reportados y otros reportados en menor frecuencia).")
    } else if (length(get(paste0("parametro_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análsis parcial (existen parámetros no reportados)")
    } else if (length(get(paste0("frecuencia_", i))) > 0){
      tabla_ducto[6,3] <- paste0("CUMPLE\r\nUsted ha dado cumplimiento a su obligación durante el período evaluado.", "\n\nNota: análisis parcial (existen parámetros reportados en menor frecuencia).")
    }
    
    tabla_ducto <- tabla_ducto %>% 
      mutate(CUMPLE = case_when(
        str_detect(`ANÁLISIS DE DESEMPEÑO AMBIENTAL`, "CUMPLE") ~ "SI",
        TRUE ~ "NO"))
  }
  
  lista_tablas[[i]] <- imprimir_tabla_final(tabla_ducto)
  
}