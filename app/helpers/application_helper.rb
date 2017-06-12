module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type.to_s
      when "success"
        "alert-success" # Green
      when "error"
        "alert-danger" # Red
      when "alert"
        "alert-warning" # Yellow
      when "notice"
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end

  def detalle(campo,texto,ancho = nil)
    ancho = "col-md-4" if ancho.nil?
    content_tag :div , class: ancho do 
      content_tag :blockquote  do 
        content_tag :p do 
          content_tag(:strong,campo.to_s.capitalize) + 
          texto.to_s
        end 
      end  
    end 
  end  

  def nav_bar
    content_tag(:ul, class: "nav nav-pills nav-stacked") do
      yield
    end
  end

  def nav_link(text, path,controlador)
    options = controller.controller_name ==controlador ? { class: "active" } : {}
    content_tag(:li, options) do
      link_to text, path, style: "font-size:13px;"
    end
  end

  def menu 
    tag = []
    if usuario_signed_in?
      #tag.append nav_link("Gorrión",root_path,"welcome")
      tag.append nav_link("Usuarios",administracion_usuarios_path,"usuarios") if can? :index,Administracion::Usuario   
      tag.append nav_link("Grupos",administracion_grupos_path,"grupos") if can? :index,Administracion::Grupo   
      tag.append nav_link("Plantillas ",plantillas_path,"plantillas")
      tag.append nav_link("Requisiciones Almacen",sigesp_solicitudsalmacens_path, "solicitudsalmacens") if can? :index_almacen,Sigesp::Solicitud                                 
      tag.append nav_link("Requisiciones Compra",sigesp_solicituds_path,"solicituds")  if can? :index_compra,Sigesp::Solicitud 
    end 

    nav_bar do 
      tag.join.html_safe
    end 
  end 

 

  def menu_usuario_cambiarunidad
    if controller.controller_name != 'sessions'
      if usuario_signed_in? 
        if session['unidad'].nil? 
          link_to unidad_index_path, class: "btn btn-default "  do |link|
            content_tag :span , :class=> "glyphicon glyphicon-cog", "aria-hidden"=>"true" do |span|
                " SELECCIONAR UNIDAD"
            end 
           end 
        else
          link_to unidad_index_path, class: "btn btn-default "   do |link|
            content_tag :span , :class=> "glyphicon glyphicon-cog", "aria-hidden"=>"true" do |span|
              session['unidad']['denuac']
            end 
          end 
        end
      end
    end
  end 

  def paginador(lista,parametros =  {} )
    clase = parametros[:clase]
    clase ||= "paginador"
    content_tag :div, class: "botonera" do 
      content_tag(:div,will_paginate(lista,renderer: BootstrapPagination::Rails, class: clase , params: parametros) ) +
      content_tag(:p,page_entries_info(lista,parametros)) 
    end 
  end 

  def buscar(url,columnas,classform = "",elements=[])
    form_tag url,remote: false, class: "navbar-form navbar-right #{classform} buscar",method: 'get',role: "search",
      style: 'margin: 0px'  do     
      content_tag :div , class: "form-group form-group-sm " do |div|
        array = [] 
        array = array + elements 
        array << text_field_tag(:search, params[:search], class:"form-control", style:"width:inherid",placeholder: "Buscar")  
        array << select_tag(:sort ,options_for_select(columnas,params[:sort]), class: "form-control",style: "width:100px;")
        array << submit_tag("Buscar",class: 'btn btn-default btn-sm', :name => nil)  
        array.join.html_safe
      end 
    end 
  end 

  def tabla_panel_responsive(titulos,contenido,parametros={})
    tbody = "table-#{controller_name}" if parametros[:tbody].nil? 
    partial = parametros[:partial] 
    style = parametros[:style]
    content_tag :div, class: "panel panel-default table-responsive", style: "min-height: 70%; height: 480px" do
      content_tag :table, class: "table table-hover", style: "text-align: center;"  do 
        contenido = content_tag(
          :tbody, 
          render(collection:contenido, partial: partial,locals: { parametros: parametros }),id:"#{tbody}")
          [table_head(titulos),contenido].join.html_safe 
        end 
      end 
  end 

  def table_head(titulos,colspan="1",put_colspan=true)
    width = 95 / titulos.size;  
    colspan = content_tag(:th,"",colspan: colspan, style: "width: 5%;")  if put_colspan  
    content_tag :thead do 
      content_tag :tr, class: "btn-primary" do 
        contenido = []
        titulos.each  do |title| 
          if title.instance_of?(Hash)
            contenido.append(content_tag(:th,title[:title], style: "text-align: center; width: #{title[:width]};")) 
          else 
            contenido.append(content_tag(:th,title, style: "text-align: center; width: #{width}%;"))
          end 
        end 
        contenido.append(colspan)
        contenido.join.html_safe 
      end 
    end 
  end 

  def content_accion symbol,options ={}, &block
    options[:class] = (options[:class].nil? ? "content-accion" : options[:class] << " content-accion")
    content_tag symbol,capture(&block),options
  end 


  def informacion_usuario
    mensaje = "#{current_usuario.nombres} "
    mensaje = "#{current_usuario.nombres} on #{session['unidad']['denuac']}" unless session['unidad'].nil?
    botonname = content_tag(:button,mensaje, class: "btn btn-default")
    caret = content_tag(:span,"",class: "caret")

    boton =  content_tag :button,data:{ toggle: "dropdown"}, class: "btn btn-default dropdown-toggle", type: "button" do 
       caret
    end  
    ul = content_tag :ul , class: "dropdown-menu" do 
      content_tag(:li,link_to("Cambiar Contraseña",  passwords_path)) +
      content_tag(:li,link_to("Cambiar Unidad ",  unidad_index_path)) +
      content_tag(:li,"",role: "separator", class: "divider")   + 
      content_tag(:li,link_to("Cerrar Sesión", destroy_usuario_session_path ,method: "delete", data: { confirm: "Quieres Cerar Session ?"} ))  
    end 
    content_tag :div , class: "navbar-right" do 
      content_tag :div, class: "btn-group" , style: " padding-top: 10px;" do 
        botonname+boton + ul 
      end 
    end 
  end  


  def moneda_venezuela(monto)
    number_to_currency(monto,unit: "Bs", format: "%n %u")
  end 
  
  class LinkRenderer < BootstrapPagination::Rails
    def link(text, target, attributes = {})
      attributes['data-remote'] = true
      super
    end
  end
  
end





