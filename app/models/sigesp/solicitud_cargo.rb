class Sigesp::SolicitudCargo < ActiveRecord::Base
	self.primary_keys = [:codemp ,:numsol ,:codcar ,:codestpro1 ,:codestpro2 ,:codestpro3 ,:codestpro4 ,:codestpro5 ,:spg_cuenta]
	self.table_name = 'public.sep_solicitudcargos'


	belongs_to :cargo, class_name: "Sigesp::Cargo", foreign_key:"codcar"
    belongs_to :solicitud, class_name: "Sigesp::Solicitud", foreign_key:"numsol"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
