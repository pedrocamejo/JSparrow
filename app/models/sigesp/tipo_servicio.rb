class Sigesp::TipoServicio < ActiveRecord::Base
	self.primary_key = 'codtipser'
	self.table_name = 'public.soc_tiposervicio'

		def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
