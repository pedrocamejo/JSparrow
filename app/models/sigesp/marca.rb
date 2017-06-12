class Sigesp::Marca < ActiveRecord::Base
	self.primary_key = 'str_idmarca'
	self.table_name = 'sigesp_espc.siv_marca'

	has_many :modelos, class_name: "Sigesp::Modelo", foreign_key:"str_idmarca"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end  
end
