class Sigesp::Cargo < ActiveRecord::Base
	self.primary_key = 'codcar'
	self.table_name = 'public.sigesp_cargos'


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.iva7 
		find("00726")
	end 

	def self.iva8
		find("00725")
	end 

end
