class Sigesp::ArticulosController < ApplicationController

	def articulos
		@lista = Sigesp::Articulo.search(params[:page], params[:search], params[:sort])
	  respond_to do |format| 
       format.js 
       format.json  
   	end		
  end 

	def almacen
		@lista = Sigesp::Articulo.search(params[:page], params[:search], params[:sort])
	  respond_to do |format| 
       format.js 
       format.json  
   	end		
	end 

	def show 
			@articulo = Sigesp::ArticuloAlmacen.find(params[:almacen_id],params[:articulo_id])
	end  

	def articulo_detalle
		@articulo = Sigesp::Articulo.find(params[:articulo_id])
	end 

end