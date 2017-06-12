module Administracion::GruposHelper


	def permisos_activos_grupo(permisos,grupo)
		contenedor = []
		permisos.each do |permiso|
			if grupo.permisos.find{|p| p.id == permiso.id }.nil?
				a = content_tag :a,class: "list-group-item" do |a|
					row = content_tag :div, class: "row" do |row|
						[ 
							content_tag(:div,content_tag(:span,"\t"+permiso.descripcion, 
									class: "glyphicon glyphicon-remove",title:"PERMISO INACTIVO"),class: "col-md-6"),
							content_tag(:div,button_to("AGREGAR",administracion_grupo_permiso_add_path(grupo,permiso),
								 class: "btn btn-default", method: "post",  data: { confirm: 'Quieres Activar este Permiso ?' } ),
								class: "col-md-6"),						  
						].join.html_safe
					end 
				end 
				contenedor.append a
			else
				a = content_tag :a,class: "list-group-item" do |a|
					row = content_tag :div, class: "row" do |row|
						[ 
							content_tag(:div,content_tag(:span,"\t"+permiso.descripcion,
									class: "glyphicon glyphicon-ok",title:"PERMISO ACTIVO"),class: "col-md-6"),
							content_tag(:div,button_to("QUITAR",administracion_grupo_permiso_del_path(grupo,permiso),
							 class: "btn btn-default", method: "post", data: { confirm: 'Quieres Inactivar este Permiso ?' } ),
								class: "col-md-6"),						  
						].join.html_safe
					end 
				end 
				contenedor.append a
			end 
		end
		div = content_tag :div , class:"list group permisos_usuario" do |div|
			contenedor.join.html_safe
		end  
	end 

end
