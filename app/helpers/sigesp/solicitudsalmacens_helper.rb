module Sigesp::SolicitudsalmacensHelper

#	def detalles_solicitud_almacen(articulo) #obj tipo Sigesp::DtArticulo 
#		# necesito la existencia de este articulo dado este almacen 
#		exis_articulo = Sigesp::ArticuloAlmacen.ArticuloAlmacen(articulo.articulo,articulo.almacen)
#		exis_articulo = exis_articulo.existencia unless exis_articulo.nil?
#
#		content_tag :tr , :id =>  articulo.codart.delete(' '), "data-almacen" =>  articulo.codalm  do |tr| 
#			arr = []
#			arr << content_tag(:td, articulo.codart) 
#			arr << content_tag(:td, articulo.articulo.denart)
#			existencia = (content_tag :input,nil,:class=>"cantidad",:required=> "required" ,:type=>"number",:style=>"width:80px;", :step=>"any", "data-existencia"=> exis_articulo,:value => articulo.canart)
#			arr << content_tag(:td,existencia)
#			arr << content_tag(:td, articulo.articulo.unidad.denunimed)
#			if articulo.almacen.nil?
#				arr << content_tag(:td,"NO DEFINIDO")
#			else
#				arr << content_tag(:td, articulo.almacen.nomfisalm)
#			end 
#			arr << content_tag(:td, exis_articulo)
#			arr << content_tag(:td,content_tag(:span,nil,:class => "glyphicon glyphicon-minus quitararticulo","aria-hidden" => "true"))
#			arr.join.html_safe
#		end 
#
#	end 

#	def agregar_articulo(solicitud) 
#		if solicitud.id.nil?
#			url = sigesp_articulos_path
#		else
#			url = sigesp_articulos_path({:almacen => solicitud.articulos[0].almacen })
#		end 
#		content_tag :button, :type => "button",:class => "btn btn-primary btn-sm cargar_articulo",
#			 "data-url" => url,"data-toggle"=> "tooltip", "data-placement" =>"left", :title=>"Agregar Articulo" do |boton| 
#    	    content_tag :span,nil,:class => "glyphicon glyphicon-plus","aria-hidden" => "true"
#	    end
#	end 


end






