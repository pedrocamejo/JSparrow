class Sigesp::SolicitudTipo < ActiveRecord::Base
	self.primary_key = 'numsol'
	self.table_name = 'sigesp_espc.sep_solicitud_tipo'

	belongs_to :solicitud, foreign_key: "numsol", class_name: "Sigesp::Solicitud" 

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.solicitud_compra()
		Sigesp::SolicitudTipo.new({
			codemp:"0001",
			bol_compra: true ,
			coddepalmacen:'00053'
		})
	end 

	def self.solicitud_almacen()
		Sigesp::SolicitudTipo.new({
			codemp:"0001",
			bol_compra: false ,
			coddepalmacen:'00053'
		})
	end 


	def almacen 
		!self.bol_compra
	end 

	def compra 
		self.bol_compra
	end 

end
