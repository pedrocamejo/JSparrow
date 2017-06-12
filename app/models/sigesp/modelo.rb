class Sigesp::Modelo < ActiveRecord::Base
	self.primary_key = 'id_modelo'
	self.table_name = 'sigesp_espc.siv_modelo'

	belongs_to :marca, foreign_key: "str_idmarca", class_name: "Sigesp::Marca" 

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end
