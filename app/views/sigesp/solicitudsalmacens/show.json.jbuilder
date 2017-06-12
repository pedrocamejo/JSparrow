json.extract! @sigesp_solicitud, :numsol, :region, :sede, :servicio ,:consol


json.articulos @sigesp_solicitud.articulos  do |art|
	json.codemp 	= art.codemp
	json.numsol 	= art.numsol
	json.codart 	= art.codart
	json.articulo = art.articulo 
	json.almacen 	= art.almacen 
	json.canart 	= art.canart 
end
 