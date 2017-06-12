json.articulos @lista  do |item|
	json.codart item.codart 
	json.enriquecido (item.enriquecido.nil? ? "N/D" : item.enriquecido.str_codfabricante )
	json.denart truncate(item.denart,length: 90)
	json.dentipart item.tipo_articulo.dentipart 
	json.denunimed item.unidad.denunimed
	json.exiart item.exiart 

	json.almacenes  item.articulo_almacenes  do |almacen|
		json.codalm  almacen.almacen.codalm 
		json.almacen almacen.almacen.nomfisalm
		json.existencia almacen.existencia 
	end 
end 
json.current_page  @lista.current_page
json.total_entries @lista.total_entries
json.per_page @lista.per_page

 