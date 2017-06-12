class Usuarios::PasswordsController <  ApplicationController #  Devise::PasswordsController

   def new

   end

   def update
 	  @usuario = current_usuario
    respond_to do |format|
      if @usuario.update(usuario_params_change_password)
        flash[:notice] = "Usuario Contraseña Actualizada  ."
        sign_in(@usuario,:bypass => true)
        format.html { redirect_to root_path, notice: 'Usuario Contraseña Actualizada  .' }
        format.json { render action: 'show', status: :created, location: root_path}
      else
        format.html { render action: 'new' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end 

  def usuario_params_change_password
    params.require(:administracion_usuario).permit(:password,:password_confirmation)
  end
end
