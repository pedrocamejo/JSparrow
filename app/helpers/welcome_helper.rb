module WelcomeHelper

	def error_mensaje(exception,style= {}) 
		permiso =   Administracion::Permiso.permiso(exception.action,exception.subject)
		content_tag :h4, class: "alert alert-danger", style:style[:style] do |h4|
			"No Tienes los Permisos Suficientes para #{permiso.descripcion}"
		end  
	end 
end
