module Sigesp::ServicioSolicitudHelper

	def opciones_tipo_servicio(tipo)
		tipos = Sigesp::TipoServicio.all.collect{ |tipo| [tipo.dentipser,tipo.codtipser] }
		tipos.insert(0,[" -----  ", ""])
		options_for_select(tipos,tipo)
	end 

	def btn_servicio(item)
		content_tag :a,
			href:  "#",
			class: "servicio",
			onclick: "solicitud.agregar_servicio('#{item.codser}')" do |a|
			content_tag :span,"",:class => "glyphicon glyphicon-plus", "aria-hidden" => true
		end 
	end 
end
