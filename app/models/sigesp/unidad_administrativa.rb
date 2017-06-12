class Sigesp::UnidadAdministrativa < ActiveRecord::Base
	self.primary_key = :coduniadm
	self.table_name = 'public.spg_unidadadministrativa'

	has_many :unidades, class_name: "Sigesp::UnidadAdministrativaDetalle", foreign_key: "coduniadm"

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end


	def self.unidades_administrativas(fuenteFinanciamiento)
		# cuales son sus spg_ep3
		sql = """ inner join public.spg_ep3 on  
				public.spg_ep3.codestpro1 = public.spg_dt_unidadadministrativa.codestpro1
			and public.spg_ep3.codestpro3 = public.spg_dt_unidadadministrativa.codestpro3
			and public.spg_ep3.codestpro2 = public.spg_dt_unidadadministrativa.codestpro2
		"""
		joins(:unidades).joins(sql).where("public.spg_ep3.codfuefin = ?",fuenteFinanciamiento)
	end


	def self.unidades_administrativas2(fuenteFinanciamiento)



	end 

 end
