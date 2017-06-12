module Sigesp::SedeServicioHelper

	def opciones_servicio(servicio,sede)
	#toda las sedes de esa region 
		servicios = []
		servicios.insert(0,["Seleccione",""])
		unless sede.nil? 
			servicios += sede.servicios.collect { |servicio| [servicio.str_descripcion,servicio.str_codservicio]}
			unless servicio.nil?
				options_for_select(servicios,servicio.id) 
			else 
				options_for_select(servicios) 
			end 
		else
			options_for_select(servicios) 
		end 
	end
end
