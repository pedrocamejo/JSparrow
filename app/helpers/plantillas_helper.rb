module PlantillasHelper


	def	tipo_plantilla plantilla 
		if plantilla.tipo == 1
			"ARTICULO"
		else
			"SERVICIO"
		end 
	end 



  def titulo(text ,text2="")
    content_tag :div, class: "page-header2" do 
      content_tag :h4 do
        ["#{text} ",content_tag(:small,text2)].join.html_safe
      end 
    end 
  end 

  def index_titulo
    titulo(controller.controller_name.humanize.capitalize)    
  end 

  def nuevo_titulo
    titulo(controller.controller_name.humanize.capitalize,"Nuevo")    
  end 

  def editar_titulo
    titulo(controller.controller_name.humanize.capitalize,"Editar")    
  end 
  
	def agregar_articulo_servicio_plantilla(plantilla)
		if plantilla.tipo == 1 
			url = sigesp_articulos_path
		    content_tag :button, :type => "button",:class => "btn btn-primary btn-sm  cargar_articulo","data-url" => url do |boton| 
		          content_tag :span,nil,:class => "glyphicon glyphicon-plus","aria-hidden" => "true"
		    end
		else
		    url = sigesp_servicios_solictud_path
		    content_tag :button, :type => "button",:class => "btn btn-primary  btn-sm cargar_articulo",
		       "data-url" => url do |boton| 
		        content_tag :span,nil,:class => "glyphicon glyphicon-plus","aria-hidden" => "true"
		    end
		end 
	end 
 
 	def btn_plantilla(plantilla,compra,articulo)
		url = plantilla_articulos_path(plantilla,compra:compra,articulo:articulo) 
		content_tag :a, :href => "#", :class  => "plantilla", "data-url"=> url do |a|
			content_tag :span,"",:class => "glyphicon glyphicon-ok", "aria-hidden" => true
		end 
	end 

	def seleccionar_articulo_plantilla(item,compra)
        porcar = (item.cargo_activo().nil? ? 0 : item.cargo_activo().porcar)
        codcar = (item.cargo_activo().nil? ? '---' : item.cargo_activo().codcar)
		content_tag :input, :type => "checkbox", "data-codigo" => item.codart,
            "data-unidad"=>item.unidad.denunimed,"data-porcar"=> porcar,
            "data-codcar"=>codcar,        
			"data-denom" => item.denart,"data-unidad" => item.unidad.denunimed do |ck|
		end 
	end 

	def seleccionar_servicio_plantilla(item,compra)
        porcar = (item.cargo_activo().nil? ? 0 : item.cargo_activo().porcar)
        codcar = (item.cargo_activo().nil? ? '---' : item.cargo_activo().codcar)
		content_tag :input, :type => "checkbox", "data-codigo" => item.codser,
            "data-unidad"=>item.unidad.denunimed,"data-porcar"=> porcar,
            "data-codcar"=>codcar,        
			"data-denom" => item.denser,"data-unidad" => item.unidad.denunimed do |ck|
		end 
	end 


end
