class Sigesp::Unidad < ActiveRecord::Base
	self.primary_key = 'codunimed'
	self.table_name = 'public.siv_unidadmedida'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
