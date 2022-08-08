# ---
# -- CARGAR PAQUETES
# ---
lista_paquetes <- c("dplyr", "flextable", "dplyr", "tidyr",
                    "readxl", "purrr", "lubridate", "knitr", 
                    "stringr", "filesstrings", "officer", 
                    "leaflet", "mapview") 
nuevos_paquetes <- lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]
lapply(nuevos_paquetes, install.packages); lapply(lista_paquetes, require, character.only = TRUE)
rm(lista_paquetes, nuevos_paquetes)

# ---
# -- CARGAR DATOS
# ---
verificaciones_todo <- read.csv("Datos/Verificaciones.csv")

resoluciones_todo <- read.csv("Datos/Resoluciones.csv")

param_no_reporta_todo <- read.csv("Datos/NoReportaParametro.csv")

param_no_reporta_remuestra_todo <- read.csv("Datos/NoReportaParametroRemuestra.csv")

excedencia_todo <- read.csv("Datos/Excedencia.csv")

coord_todo <- read.csv("Datos/UFs.csv")

# ---
# -- LOOP DE GENERACIÓN DE DOCUMENTOS
# ---

# Lista de establecimientos para generar cartas
est <- verificaciones_todo %>% 
  distinct(EstablecimientoRetc) %>% 
  pull()

for (z in est){
  
  # DATOS CORRESPONDIENTES AL ESTABLECIMIENTO QUE SE ESTÁ GENERANDO
  verificaciones <- verificaciones_todo %>% filter(EstablecimientoRetc == z)
  resoluciones <- resoluciones_todo %>% filter(DuctoId %in% unique(verificaciones$DuctoId))
  param_no_reporta <- param_no_reporta_todo %>% filter(DuctoId %in% unique(verificaciones$DuctoId))
  param_no_reporta_remuestra <- param_no_reporta_remuestra_todo %>% filter(DuctoId %in% unique(verificaciones$DuctoId))
  excedencia <- excedencia_todo %>% filter(DuctoId %in% unique(verificaciones$DuctoId))
  
  UF_select <- coord_todo %>% filter(EstablecimientoRetc == z) %>% distinct()
  
  rmarkdown::render(
    input = "CartaAutomatica.rmd"
    , output_dir = "Cartas/"
    , output_file = paste0("Carta_", unique(verificaciones$EstablecimientoRetc))
    , params = list(UF = z, Anio = 2022, Mes = 7))
  
}

