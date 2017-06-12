class Sigesp::DtsCargo < ActiveRecord::Base
	self.primary_keys =  [:codemp ,:numsol ,:codser ,:codcar]	
    self.table_name = 'public.sep_dts_cargos'

	belongs_to :cargo,
        foreign_key: "codcar",
        class_name: "Sigesp::Cargo"

	belongs_to :servicio,
        foreign_key: "codser",
        class_name: "Sigesp::ServicioSolicitud"

	belongs_to :solicitud,
        foreign_key: "numsol",
        class_name: "Sigesp::Solicitud"

    validates :cargo,presence: {message: 'Seleccione '}
    validates :servicio,presence: {message: 'Seleccione '}
    validates :solicitud,presence: {message: 'Ingrese '}
    validates :monbasimp,presence: {message: 'Ingrese '}
    validates :monimp,presence: {message: 'Seleccione '}
    validates :monto,presence: {message: 'Ingrese '}

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end
