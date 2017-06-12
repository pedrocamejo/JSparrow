class Usuarios::SessionsController < Devise::SessionsController
   def new
     super
   end

   def create
   	self.resource = warden.authenticate(auth_options) # it's a user :-D 
		set_flash_message(:notice, :signed_in) if is_flashing_format?
		unless (self.resource.nil?)
			sign_in(resource_name,self.resource)
			if (self.resource.unidad.nil?)
				respond_with resource, location: unidad_index_path
			else
				unidad = {}
				unidad['coduac'] = self.resource.unidad.coduac
		    unidad['denuac'] = self.resource.unidad.denuac
				session['unidad'] = self.resource.unidad
				flash[:notice] += " Unidad Funcional #{unidad}"
				respond_with resource, location: after_sign_in_path_for(resource)
			end 		
		else
      @error = "Username o Password Invalido "
      @usuario = Administracion::Usuario.new
      @usuario.username = params[:usuario][:username]
      @usuario.password = params[:usuario][:password]
      render "welcome/index"
   	end 
   end 

end
