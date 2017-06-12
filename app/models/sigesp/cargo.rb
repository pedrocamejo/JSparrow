class Sigesp::Cargo < ActiveRecord::Base
	self.primary_key = 'codcar'
	self.table_name = 'public.sigesp_cargos'


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end
