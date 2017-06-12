
json.articulo do 
	json.codart 			@articulo.articulo.codart 
	json.enriquecido 	(@articulo.articulo.enriquecido.nil? ? "N/D" : @articulo.articulo.enriquecido.str_codfabricante )
	json.denart 			truncate(@articulo.articulo.denart,length: 90)
	json.dentipart 		@articulo.articulo.tipo_articulo.dentipart 
	json.denunimed 		@articulo.articulo.unidad.denunimed
	json.exiart 			@articulo.articulo.exiart 
end 


json.almacen do 
		json.codalm  			@articulo.almacen.codalm 
		json.almacen 			@articulo.almacen.nomfisalm
end 

json.existencia 	@articulo.existencia 
 