class Sigesp::Servicio < ActiveRecord::Base

	self.primary_key = 'str_codservicio'
	self.table_name = 'sigesp_espc.sigesp_servicios'

	belongs_to :tipo_servicio, foreign_key: "codtipser", class_name: "Sigesp::TipoServicio"  

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.obtenerServicio(codigo)
		if codigo.nil?
			return nil
		elsif codigo.delete(' ').size == 0
		    return nil
	    else
			lista = Sigesp::Servicio.where(" seq_servicio = ? ",codigo)
			if (lista.size() != 0)
				lista[0]
			else
				nil 
			end 	    	
		end  
	end 
end
