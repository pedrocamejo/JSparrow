class Sigesp::Region < ActiveRecord::Base
	self.primary_key = 'str_codregion'
	self.table_name = 'sigesp_espc.sigesp_regiones'
	
	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.obtenerRegion(codigo)
		if codigo.nil?
			return nil
		elsif codigo.delete(' ').size == 0
		    return nil
	    else 
			lista = Sigesp::Region.where(" seq_region = ? ",codigo)
			if (lista.size() != 0)
				lista[0]
			else
				nil 
			end 
		end		
	end 



end

