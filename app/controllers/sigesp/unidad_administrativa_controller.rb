class Sigesp::UnidadAdministrativaController < ApplicationController
    def index 
		if params[:fuente].nil?
			render json: Sigesp::UnidadAdministrativa.all 
		else 
   	   render json: Sigesp::UnidadAdministrativa.buscar_unidad_ejecutora(params[:fuente])
		end 
	  end
end


