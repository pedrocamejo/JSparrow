class Sigesp::ArticuloalamcenController < ApplicationController

  def index
	unless params[:articulo].nil?
		codigo = params[:articulo].to_s.delete(' ')
		@alamcenearticulos = Sigesp::ArticuloAlmacen.where(" siv_articuloalmacen.codart =? ",codigo) 
		respond_to do |format|
	        format.json 
		end	
	else
  		render nothing: true , status: 500
  	end 
  end
end
