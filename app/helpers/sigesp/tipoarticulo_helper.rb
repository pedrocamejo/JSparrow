module Sigesp::TipoarticuloHelper
	def opciones_tipo(tipo)
		tipos = Sigesp::TipoArticulo.all.collect{ |tipo| [tipo.dentipart,tipo.codtipart] }
		tipos.insert(0,[" -----  ", ""])
		options_for_select(tipos,tipo)
	end 
end
