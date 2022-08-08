coord_ducto <- UF_select %>% 
  select(Longitud, Latitud)

ma <- leaflet(coord_ducto) %>% 
  setView(lng = mean(coord_ducto$Longitud), lat = mean(coord_ducto$Latitud), zoom = 17) %>% 
  addProviderTiles('Esri.WorldImagery')

#mapshot(ma, file = "mapa.png")
