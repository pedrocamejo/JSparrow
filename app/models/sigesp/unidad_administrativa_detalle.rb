class Sigesp::UnidadAdministrativaDetalle < ActiveRecord::Base

	self.primary_keys =[:codemp , :coduniadm , :codestpro1 , :codestpro2 , :codestpro3 , :codestpro4 , :codestpro5 , :estcla]

	self.table_name = 'public.spg_dt_unidadadministrativa'
	belongs_to :unidad, class_name: "Sigesp::UnidadAdministrativa", foreign_key: "coduniadm"
	belongs_to :spg_ep3, class_name:"Sigesp::SpgEp3", foreign_key: [:codestpro1, :codestpro2, :codestpro3]

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.unidades_administrativas(fuenteFinanciamiento)
		joins(:unidad,:spg_ep3).where("public.spg_ep3.codfuefin = ?",fuenteFinanciamiento)
	end 

end
