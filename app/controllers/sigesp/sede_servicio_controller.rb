class Sigesp::SedeServicioController < ApplicationController



	def servicios 
		if params[:sede].nil?
			render json: Sigesp::Servicio.all 
		else 
			arr = Sigesp::Servicio
			.joins('inner join sigesp_espc.sigesp_serviciosedes ss on int_servicio = seq_servicio')
			.where('int_sede = ?',params[:sede])
   	  render json: arr   
		end 
	end


 	def sedes 
		if params[:region].nil?
			render json: Sigesp::Sede.all 
		else 
      render json:  Sigesp::Sede.where(int_region: params[:region])
		end 
	end

 	def regiones 
		render json: Sigesp::Region.all 
	end

end



