class Sigesp::SpgEp2 < ActiveRecord::Base
	self.primary_key = 'codemp'
	self.table_name = 'public.spg_ep2'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
