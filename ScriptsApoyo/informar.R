
n <- 1
for (d in unique(lista_ductos$DuctoId)){
  
assign(paste0("informar_texto", n), datos_informar %>% 
         filter(DuctoId == d))
  
assign(paste0("informar_informanodescarga", n), 
       ifelse(unique(pull(filter(verificaciones, DuctoId == d), Informa)) == "SI" & unique(pull(filter(verificaciones, DuctoId == d), EfectuaDescarga)) == "NO", 
              "SI", 
              "NO")
       )
  
n <- n + 1
}

