json.servicio do 
	json.codser 			@servicio.codser 
	json.denser 			truncate(@servicio.denser,length: 90)
	json.dentipart 		@servicio.tipo_servicio.dentipser 
	json.denunimed 		@servicio.unidad.denunimed
	json.cargo_activo @servicio.cargo_activo
end 