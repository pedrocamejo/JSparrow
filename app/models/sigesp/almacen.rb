class Sigesp::Almacen < ActiveRecord::Base
	self.primary_key = 'codalm'
	self.table_name = 'public.siv_almacen'

	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

	def self.buscarAlmacen(codigo)
		almacenes = Sigesp::Almacen.where("codalm like ? ","%#{codigo}%")
		if almacenes.size == 0
			nil
		else
			almacenes[0]
		end
	end 

end



