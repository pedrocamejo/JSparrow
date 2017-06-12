module Sigesp::ArticulosHelper

	def opciones_almacen_articulo(item,almacen = params[:almacen] )
		if almacen.blank?
			alamcenes = item.articulo_almacenes.collect{ |a| [a.nombre_existencia,a.almacen.id,{ "data-existencia" => a.existencia, "data-nombre" =>  a.almacen.nomfisalm}]}
			alamcenes.insert(0,["ALMACEN NO DEFINIDO  ",nil]) if alamcenes.size == 0
			options_for_select(alamcenes)
		else
			alamcenes = Sigesp::ArticuloAlmacen.where(codalm:almacen,codart:item.id).collect{ |a| [a.nombre_existencia,a.almacen.id,{ "data-existencia" => a.existencia, "data-nombre" =>  a.almacen.nomfisalm}]}
			alamcenes.insert(0,["ALMACEN NO DEFINIDO  ",nil]) if alamcenes.size == 0
			options_for_select(alamcenes)
		end 
	end 

	def btn_articulo(item)
		content_tag :a,
			href:  "#",
			class: "articulo",
			onclick: "solicitud.agregar_articulo('#{item.codart}')" do |a|
			content_tag :span,"",:class => "glyphicon glyphicon-plus", "aria-hidden" => true
		end 
	end 

	def btn_articulo_almacen(item)
		content_tag :a,
			href: "#",
			class: "articulo",
			onclick: "solicitudAlmacen.agregar_articulo('#{item.codart}')" do |a|
			content_tag :span,"",:class => "glyphicon glyphicon-plus", "aria-hidden" => true
		end 
	end 
end
 


