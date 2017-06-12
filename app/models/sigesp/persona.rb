class Sigesp::Persona < ActiveRecord::Base
	self.primary_key = 'codper'
	self.table_name = 'public.sno_personal'
	
	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
