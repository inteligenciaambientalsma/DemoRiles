
texto_tabla_resoluciones <- resoluciones %>% 
  distinct(Sigla, Numero, FechaResolucion) %>% 
  mutate(texto = str_squish(paste("Res. Ex.", Sigla, " N°", Numero, "de fecha", FechaResolucion))) %>% 
  pull(texto) %>% paste(collapse = "\n")

texto_tabla_norma <- resoluciones %>% 
  distinct(GlosaNormaEmision, TablaDecretoSupremoGlosa) %>% 
  mutate(texto = paste(GlosaNormaEmision, "-", TablaDecretoSupremoGlosa)) %>% 
  pull(texto) %>% paste(collapse = "\n")
  
lista_ductos <- verificaciones %>% distinct(DuctoId, NombreDucto)

##########################
## CRITERIOS A CHEQUEAR ##
##########################

## INFORMA
datos_informar <- verificaciones %>% 
  filter(Informa == "NO") %>% 
  distinct(DuctoId)

## FRECUENCIA
datos_frecuencia <- verificaciones %>% 
  filter(ApruebaFrecuencia == 2) %>% 
  distinct(DuctoId, GlosaParametro, FrecuenciaExigida)

## PARAMETROS
datos_parametros <- param_no_reporta %>% 
  distinct(DuctoId, GlosaParametro)

## REMUESTREO
datos_remuestreos <- verificaciones %>% 
  filter(PresentaRemuestra == "NO")

## PARAMETROS REMUESTREO
datos_parametros_remuestreos <- param_no_reporta_remuestra %>%
  distinct(DuctoId, GlosaParametro)

## SUPERACION
datos_superacion <- excedencia %>% 
  filter(DuctoId %in% c(verificaciones %>% filter(ParametrosBajoNorma == "NO") %>% distinct(DuctoId))) %>% 
  distinct(DuctoId, GlosaParametro)

