class Public::SpgMinisterioUa < ActiveRecord::Base

	self.primary_key = 'coduac'
	self.table_name = 'public.spg_ministerio_ua'

	def self.ninguno(codigo)
		if codigo == ('-----') or codigo == nil or codigo.empty?()
			nil
		else
			Public::SpgMinisterioUa.find(codigo)
		end 
	end 

end
