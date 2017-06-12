class Sigesp::ServicioSolicitudController < ApplicationController

  def index
		@lista = Sigesp::ServicioSolicitud.search(params[:page], params[:search], params[:sort])
  end

  def show
		@servicio = Sigesp::ServicioSolicitud.find(params[:servicio_id])
  end 

end
