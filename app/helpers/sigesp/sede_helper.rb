module Sigesp::SedeHelper



	def opciones_sedes(sede,region)
	#toda las sedes de esa region 
		
		unless region.nil?
			sedes = Sigesp::Sede.where("int_region = ? ",region.seq_region).collect { |sede| [sede.str_descripcion,sede.str_codsede]} 
		else
			sedes= []
		end 
		sedes.insert 0,["Seleccione",""]
		unless sede.nil?
			options_for_select(sedes,sede.id) 
		else
			options_for_select(sedes) 
		end 
	end

end
