class Sigesp::SpgEp3 < ActiveRecord::Base
	self.primary_keys  = [:codestpro1, :codestpro2, :codestpro3]
	self.table_name = 'public.spg_ep3'

	belongs_to :fuenteFinanciamientos, class_name: "Sigesp::FuenteFinanciamiento",
		 foreign_key:"codfuefin"
   
	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
