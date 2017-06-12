class Sigesp::FuenteFinanciamiento < ActiveRecord::Base
	self.primary_key = 'codfuefin'
	self.table_name = 'public.sigesp_fuentefinanciamiento'

	has_many :spg_ep3, foreign_key: "codfuefin", class_name: "Sigesp::SpgEp3"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
