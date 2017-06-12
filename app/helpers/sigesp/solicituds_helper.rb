module Sigesp::SolicitudsHelper

 # def detalles_solicitud_compra_cargo(articulo) #obj tipo Sigesp::DtArticulo 
 #   # necesito la existencia de este articulo dado este almacen 
 #   cargo = articulo.articulo.cargo_activo()
 #  content_tag :tr , :id =>  articulo.codart.delete(' '), 
 #           "data-codcar"=> cargo.id, "data-porcar"=> cargo.porcar  do |tr| 
 #     arr = []
 #     arr << content_tag(:td, articulo.codart) 
 #     arr << content_tag(:td, articulo.articulo.denart)
 #     arr << content_tag(:td, articulo.articulo.unidad.denunimed)
 #     canart = articulo.canart
 #     monpre  = articulo.monpre 
 #     monart = articulo.monart  
 #     existencia = (
 #       content_tag :input,
 #         nil,
 #         :class=>"cantidad",
 #         :type=>"number",
 #         :style=>"width:80px;",
 #         :step=>"any",
 #         :value => canart,
 #         :min=>0,
 #         :required=>"required")
 #     precio = (
 #         content_tag :input,
 #         nil,
 #         :class=>"precio",
 #         :type=>"number",
 #         :style=>"width:80px;",
 #         :step=>"any",
 #         :value =>monpre,
 #         :min=>0,
 #         :required=>"required" )
 #     total = (
 #         content_tag :input,
 #         nil,
 #         :class=>"total",
 #         :type=>"number",
 #         :style=>"width:80px;",
 #         :step=>"any",
 #         :value =>monart,
 #         disabled: true,
 #         :min=>0,
 #         :required=>"required")
 #
 #     arr << content_tag(:td,existencia)
 #     arr << content_tag(:td,precio)
 #     arr << content_tag(:td,total)
 #     arr << content_tag(:td,content_tag(:span,nil,:class => "glyphicon glyphicon-minus quitararticulo","aria-hidden" => "true"))
 #     arr.join.html_safe
 #   end 
 # end  

 # def detalles_servicios_compra_cargo(servicio) #obj tipo Sigesp::DtArticulo 
 #   # necesito la existencia de este articulo dado este almacen 
 #   cargo = servicio.servicio.cargo_activo()
 #   content_tag :tr , :id =>  servicio.codser.delete(' '), 
 #      "data-codcar"=> cargo.id, "data-porcar"=> cargo.porcar  do |tr|
 #     arr = []
 #     arr << content_tag(:td, servicio.codser) 
 #     arr << content_tag(:td, servicio.servicio.denser)
 #     arr << content_tag(:td, servicio.servicio.unidad.denunimed)
 #     cant =  servicio.canser 
 #     monpre  = servicio.monser 
 #     monart = servicio.monser  
 #     existencia = (content_tag :input,nil,:class=>"cantidad" ,:type=>"number",
 #       :style=>"width:80px;", :step=>"any",:value => cant,:min=>0,:required=>"required")
 #     precio = (content_tag :input,nil,:class=>"precio",:type=>"number",
 #       :style=>"width:80px;",:step=>"any",:value =>monpre,:min=>0,:required=>"required")
 #     total = (content_tag :input,nil,:class=>"total" , :type=>"number",
 #       :style=>"width:80px;",:step=>"any",:value =>monart, disabled: true,:min=>0,:required=>"required")
 #
 #     arr << content_tag(:td,existencia)
 #     arr << content_tag(:td,precio)
 #     arr << content_tag(:td,total)
 #     arr << content_tag(:td,content_tag(:span,nil,:class => "glyphicon glyphicon-minus quitararticulo","aria-hidden" => "true"))
 #     arr.join.html_safe
 #   end 
 # end 



 # def detalles_servicios(servicio) #obj tipo Sigesp::DtArticulo 
 #   # necesito la existencia de este articulo dado este almacen 
 #   content_tag :tr , :id =>  servicio.codser.delete(' ')   do |tr| 
 #     arr = []
 #     arr << content_tag(:td, servicio.codser) 
 #     arr << content_tag(:td, servicio.servicio.denser)
 #     existencia = (content_tag :input,nil,:class=>"cantidad" ,:type=>"number",
 #       :style=>"width:80px;", :step=>"any",:value => servicio.canser,:min=>0,:required=>"required")
 #     arr << content_tag(:td,existencia)
 #     arr << content_tag(:td, servicio.servicio.unidad.denunimed)
 #     arr << content_tag(:td,content_tag(:span,nil,:class => "glyphicon glyphicon-minus quitararticulo","aria-hidden" => "true"))
 #     arr.join.html_safe
 #   end 
 # end 


  def estadoSolicitud(estado)
    if estado == 'E'
     "EMITIDA"
    elsif estado == 'R'
     "REGISTRADA"
    elsif estado == 'C'
     "CONTABILIZADA"
    elsif estado == 'A'
     "ANULADA"
    elsif estado == 'P'
     "PROCESADA"
    elsif estado == 'D'
     "DESPACHADA"
    elsif estado == 'I'
     "Espera Aprobacion Admin"
    elsif estado == 'O'
     "Analisis Oferta"
    elsif estado == 'V'
     "Espera Aprobacion Pres"
    elsif estado == 'L'
     "Parcial"
    end
  end

 def tipoSolicitud(tipo)
   
   if tipo == 'BIENES PRECOMROMISO'
   	"Producto"
   elsif tipo == 'SERVICIOS PRECOMPROMISOS'
   	"Servicio"
   end
 end




  def buscar_unidades_administrativa(url,columnas,classform = "",elements=[])
    form_tag url,remote: false, class: "navbar-form navbar-right #{classform} buscar",method: 'get',role: "search",
      style: 'margin: 0px'  do     
      content_tag :div , class: "form-group form-group-sm " do |div|
        array = [] 
        array = array + elements 
        if current_usuario.compra?
          unidades = Public::SpgMinisterioUa.all.collect { |unidad| [unidad.denuac,unidad.id]}
          unidades.insert(0,["NINGUNO",nil])
          array << select_tag(:unidad,
            options_for_select(unidades,params[:unidad]),
            class: "form-control",
            onchange: "this.form.submit()",
            style: "width:200px;")
        end 
        array << text_field_tag(:search, params[:search], class:"form-control", style:"width:inherid",placeholder: "Buscar")  
        array << select_tag(:sort ,options_for_select(columnas,params[:sort]), class: "form-control",style: "width:100px;")
        array << submit_tag("Buscar",class: 'btn btn-default btn-sm', :name => nil)  
        array.join.html_safe
      end 
    end 
  end 




  def tipo_requisicion(tipo)
    if tipo == "01"
      "Producto"
    else
      "Servicio"
    end 
  end 

 
  def opciones_unidad_administrativa(unidad,fuente)
  #toda las sedes de esa region 
    unless unidad.nil?
      unidades =Sigesp::UnidadAdministrativaDetalle.
        unidades_administrativas(fuente.id).collect{ |u|[u.unidad.denuniadm,u.coduniadm,{'data-codestpro1' => u.codestpro1,'data-codestpro2' => u.codestpro2,'data-codestpro3' => u.codestpro3,'data-codestpro4' => u.codestpro4,'data-codestpro5' => u.codestpro5}] }   
    else
      unidades= []
    end 
    unidades.insert 0,["Seleccione",""]
    unless unidad.nil?
      options_for_select(unidades,unidad.id) 
    else
      options_for_select(unidades) 
    end 
  end
 


#  def agregar_servicio(solicitud) 
#    url = sigesp_servicios_solictud_path
#    content_tag :button, :type => "button",:class => "btn btn-primary btn-sm cargar_servicio",
#       "data-url" => url do |boton| 
#          content_tag :span,nil,:class => "glyphicon glyphicon-plus","aria-hidden" => "true"
#      end
#  end 
# 
#  def opciones_unidades_administrativas(fuentefinanciamiento,unidad)
#    #fuente ninguna
#    unless fuentefinanciamiento.nil?                    
#      if fuentefinanciamiento.id != "--"  # es la vacia 
#        unidades  = Sigesp::UnidadAdministrativa.unidades_administrativas(
#          fuentefinanciamiento).collect { |ff| [ff.denuniadm,ff.coduniadm]} 
#      else
#        unidades = Sigesp::UnidadAdministrativa.where(coduniadm:"----------").collect { |ff| [ff.denuniadm,ff.coduniadm]} 
#      end 
#    else
#      unidades = Sigesp::UnidadAdministrativa.where(coduniadm:"----------").collect { |ff| [ff.denuniadm,ff.coduniadm]} 
#    end 
#    unless unidad.nil?
#      options_for_select(unidades,unidad.id) 
#    else
#      options_for_select(unidades) 
#    end 
#  end 

end








 
