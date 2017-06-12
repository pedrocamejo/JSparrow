
json.articulo do 
	json.codart 			@articulo.codart 
	json.enriquecido 	(@articulo.enriquecido.nil? ? "N/D" : @articulo.enriquecido.str_codfabricante )
	json.denart 			truncate(@articulo.denart,length: 90)
	json.dentipart 		@articulo.tipo_articulo.dentipart 
	json.denunimed 		@articulo.unidad.denunimed
	json.exiart 			@articulo.exiart 
	json.ultcosartaux @articulo.ultcosartaux
	json.cargo_activo @articulo.cargo_activo
end 