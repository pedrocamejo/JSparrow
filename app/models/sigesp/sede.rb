class Sigesp::Sede < ActiveRecord::Base
	self.primary_key = 'str_codsede'
	self.table_name = 'sigesp_espc.sigesp_sedes'

	belongs_to :region, foreign_key: "int_region",class_name: "Sigesp::Region" 

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def servicios 
		Sigesp::Servicio.joins('inner join sigesp_espc.sigesp_serviciosedes ss on int_servicio = seq_servicio')
			.where('int_sede = ?',seq_sede)
	end


	def self.obtenerSede(codigo)
		if codigo.nil?
			return nil
		elsif codigo.delete(' ').size == 0
		    return nil
	    else 
			lista = Sigesp::Sede.where(" seq_sede = ? ",codigo)
			if (lista.size() != 0)
				return lista[0]
			else
				return nil 
			end
		end  
	end 
end
