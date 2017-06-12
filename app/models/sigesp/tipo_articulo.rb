class Sigesp::TipoArticulo < ActiveRecord::Base

	self.primary_key = 'codtipart'
	self.table_name = 'public.siv_tipoarticulo'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
