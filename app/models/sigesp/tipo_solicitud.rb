class Sigesp::TipoSolicitud < ActiveRecord::Base
	self.primary_key = 'codtipsol'
	self.table_name = 'public.sep_tiposolicitud'

    has_many :Solicituds, class_name: "Sigesp::Solicitud", foreign_key: "codtipsol"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
