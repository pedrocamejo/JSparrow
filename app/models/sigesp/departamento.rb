class Sigesp::Departamento < ActiveRecord::Base
	self.primary_key = 'coddep'
	self.table_name = 'sigesp_espc.sno_departamento'

	belongs_to :responsable, foreign_key: "codperresponsable",class_name: "Sigesp::Persona" 

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

end


