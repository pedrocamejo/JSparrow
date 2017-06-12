class Sigesp::DtCargo < ActiveRecord::Base
	self.primary_keys = [:codemp,:numsol,:codart,:codcar]
	self.table_name = 'public.sep_dta_cargos'

	belongs_to :cargo,
		class_name: "Sigesp::Cargo",
		foreign_key:"codcar"
  
  belongs_to :articulo,
  	class_name: "Sigesp::Articulo",
  	foreign_key:"codart"

	belongs_to :solicitud,
		foreign_key: "numsol",
		class_name: "Sigesp::Solicitud"

  validates :articulo,presence: {message: 'Seleccione '}
  validates :cargo,presence: {message: 'Seleccione '}
  validates :solicitud,presence: {message: 'Ingrese '}
  validates :monbasimp,presence: {message: 'Ingrese '}
  validates :monimp,presence: {message: 'Seleccione '}
  validates :monto,presence: {message: 'Ingrese '}


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end
