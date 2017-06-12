class Sigesp::SolicitudUser < ActiveRecord::Base
	self.primary_key = 'numsol'
	self.table_name = 'sigesp_espc.sep_solicitud_user'

	belongs_to :solicitud, foreign_key: "numsol", class_name: "Sigesp::Solicitud"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end


	def self.solicitudnueva(numsol,usuario) 
		solicitudUsuario = Sigesp::SolicitudUser.new
		solicitudUsuario.codemp = "0001"
		solicitudUsuario.usuario = "#{usuario.nombres} #{usuario.apellidos}"
		solicitudUsuario.numsol = numsol
		solicitudUsuario
	end 

end
