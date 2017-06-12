class Sigesp::CtrlRequisicion < ActiveRecord::Base
	self.primary_key = 'coduac'
	self.table_name = 'sigesp_espc.sigesp_ctrl_requisicion'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def codigo_solicitud()
	    self.valor  += 1
	    prefijo_0 =  self.prefijo.delete('0')
	    ajuste = 15 - prefijo_0.size  
		return  prefijo_0 + (self.valor).to_s.rjust(ajuste,'0')
	end 

	def self.control_almacen(unidad)
		#Unidad cargada en la session 
   	Sigesp::CtrlRequisicion.where(coduac: unidad['coduac']).first
	end 

	def self.control_almacen?(unidad)
		#Unidad cargada en la session 
   	Sigesp::CtrlRequisicion.where(coduac: unidad['coduac']).exists?
	end 

	def self.control_compra(unidad)
		#Unidad cargada en la session 
   	control_almacen(unidad)
	end 

end
