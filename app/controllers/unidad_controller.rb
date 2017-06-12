class UnidadController < ApplicationController
  
  def unidad
		unless current_usuario.nil? 
			@unidades = current_usuario.unidades		
		else
			flash['error'] = "Debe Iniciar Sessión para poder cambiar su unidad "
	    redirect_to root_path
		end
  end

  def cambiarunidad
  	codigo = params[:codigo]
		unless current_usuario.nil? 
			@unidad = Public::SpgMinisterioUa.find(codigo) 		
			if @unidad.nil?
				flash['error'] = " Error al Cargar la Unidad Administrativa "
			else
				current_usuario.update(unidad_id: @unidad.coduac)
				unidad = {}
				unidad['coduac'] = @unidad.coduac
		    unidad['denuac'] = @unidad.denuac
				session['unidad'] = unidad
				flash['notice'] = "Unidad Funcional Cambiada"
				return redirect_to root_path
			end 
		else
			flash['error'] = "Debe Iniciar Sessión para poder cambiar su unidad "
	    redirect_to root_path
		end
  end
end
