class Sigesp::ArticuloEnriquecido < ActiveRecord::Base
	self.primary_key = 'str_codart'
	self.table_name = 'sigesp_espc.siv_articulo_enriquecido'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end
