class Sigesp::CuentaGasto < ActiveRecord::Base
	self.primary_keys = [:codemp,:numsol,:codestpro1,:codestpro2,:codestpro3,:codestpro4,:codestpro5,:spg_cuenta]
	self.table_name = 'public.sep_cuentagasto'
	belongs_to :solicitud, foreign_key: "numsol", class_name: "Sigesp::Solicitud"


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.nuevo_gasto_servicio(solicitud,item)
		cargo = new 
		cargo.solicitud = solicitud 
		cargo.codemp = "0001"
		cargo.numsol = item.numsol
		cargo.codestpro1 = item.codestpro1
		cargo.codestpro2 = item.codestpro2
		cargo.codestpro3 = item.codestpro3
		cargo.codestpro4 = item.codestpro4
		cargo.codestpro5 = item.codestpro5
		cargo.spg_cuenta = item.spg_cuenta
		cargo.monto  = item.monser
		cargo. montoaux
		cargo.codfuefin
		cargo.cod_servicio
		cargo.cod_sede
		cargo.cod_region
		cargo.str_codregionsedeservicio
		cargo
	end 


	def self.nuevo_gasto_articulo(solicitud,item)
		cargo = new 
		cargo.solicitud = solicitud 
		cargo.codemp = "0001"
		cargo.numsol = item.numsol
		cargo.codestpro1 = item.codestpro1
		cargo.codestpro2 = item.codestpro2
		cargo.codestpro3 = item.codestpro3
		cargo.codestpro4 = item.codestpro4
		cargo.codestpro5 = item.codestpro5
		cargo.spg_cuenta = item.spg_cuenta
		cargo.monto  = item.monart
		cargo. montoaux
		cargo.codfuefin
		cargo.cod_servicio
		cargo.cod_sede
		cargo.cod_region
		cargo.str_codregionsedeservicio
		cargo
	end 
end




