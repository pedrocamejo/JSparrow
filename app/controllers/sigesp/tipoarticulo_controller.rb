class Sigesp::TipoarticuloController < ApplicationController
 
 	def tiposArticulos
 		@tiposarticulos =  Sigesp::TipoArticulo.all 
 		render json: @tiposarticulos.as_json(only: [:codtipart, :dentipart]) 
 	end 
end
