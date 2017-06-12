class Sigesp::UnidadadministrativaController < ApplicationController
	def unidadesAdministrativas
		@unidades  = Sigesp::UnidadAdministrativaDetalle.unidades_administrativas(params[:fuenteFinanciamiento])
	end 
end
 