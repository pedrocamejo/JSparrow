module Sigesp::SedeRegionHelper

	def opciones_regiones(region)
		regiones = Sigesp::Region.all.collect { |region| [region.str_descripcion,region.str_codregion]}
		#regiones = [region]
		regiones.insert 0,["Seleccione",""]
		unless region.nil?
			options_for_select(regiones,region.id) 
		else
			options_for_select(regiones) 
		end 
	end 
end
