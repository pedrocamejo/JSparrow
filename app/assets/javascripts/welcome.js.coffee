# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


(($) ->
  $.aplicacion = new Object()
  $.posicion = new Object()
) jQuery

(($) ->
  $.fn.campo_error = (mensaje) ->
    @parent().parent().removeClass 'has-error'
    if mensaje != undefined
      @parent().parent().addClass 'has-error'
      padre = @parent()
      label = $('<label>').text(mensaje)
      label.click ->
        @remove()
        padre.parent().removeClass 'has-error'
        return
      padre.append label
      label.addClass 'erro_campo'
    return

  $.fn.campo_error_div = (mensaje) ->
    if mensaje != undefined
      div = $('<div>',{'class':'alert alert-danger alert-dismissible','role':'alert'})
      $(this).append div
      div.append """   <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
            </button>
            #{mensaje}
      """ 
    return div 
) jQuery

###
$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  html = """
         <div class="modal" id="confirmationDialog">
          <div class="modal-dialog">
          <div class="modal-content">
           <div class="modal-header">
             <a class="close" data-dismiss="modal">×</a>
           </div>
           <div class="modal-body">
             <h3>#{message}</h3>
           </div>
           <div class="modal-footer">
             <a data-dismiss="modal" class="btn">Cancel</a>
             <a data-dismiss="modal" class="btn btn-primary confirm">OK</a>
           </div>
          </div>
          </div>
         </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)


(($) ->
  $.posicion.divcol =(componente,stamano)->
    div = $('<div>',{class:stamano})
    div.append componente     
) jQuery


(($) ->
  $.fn.exists = ()->
      return !(this.length == 0)
) jQuery

(($) ->
  close_action = (e)->
    modal = $(this).parent().parent().parent().parent()
    modal.modal('hide')
    modal.remove()
    return 
  # Cerrar Ventana 
  $.aplicacion.footer =(title_button,acion)->
    modal_footer = $('<div/>',{ class: "modal-footer" })
    button_close = $('<button/>',{ type: "button",class: "btn btn-default" })
    button_close.append "cerrar"
    button_close.on "click", close_action  
    button_action = $('<button/>',{ type: "button",class: "btn btn-primary"})
    
    if title_button != null
      modal_footer.append button_action
      button_action.on "click", acion  
      button_action.append title_button
  
    modal_footer.append button_close
    return  modal_footer
  
  $.aplicacion.crearHear =(titulo)->
    modal_header = $('<div/>',{ class: "modal-header" })
    button = $('<button/>', {
      type: "button"
      class: "close"
      "data-dismiss": "modal"
      "aria-label": "Close"
    })   
    span = $('<span/>',{ "aria-hidden": "true" })
    
    h4 = $('<h4/>',{class: "modal-title" })
    h4.append titulo
    
    span.append "&times;"
    button.append span

    modal_header.append button 
    modal_header.append h4 
    return  modal_header

   $.aplicacion.crearVentana =(header,body,footer,contenedor) ->
    modal = $('<div/>',{class: "modal", style:"width:100%" })
    modal_dialog = $('<div/>',{class: "modal-dialog" ,style:"width:98%" })    
    modal.append modal_dialog
    modal_content = $('<div/>',{ class: "modal-content" })    
    modal_dialog.append modal_content
    modal_content.append header
    modal_content.append body
    modal_content.append footer
    if contenedor == undefined 
      $("body").append modal   
    else
      contenedor.append modal 
    return modal 

) jQuery


(($) ->
  $.aplicacion.alerta = (contenedor,mensaje,tipo) ->
    tipo = "danger" if not tipo? 
    alerta = $('<div>',{
      "class":"alert alert-"+tipo
    }).append $('<label>').append(mensaje)
    contenedor.append alerta 
    alerta.hide 8000, (e)->
      alerta.remove()
    alerta


  $.fn.opcion_select = () ->
    for op in $(this).children()
      if $(this).val() == $(op).val()
        return $(op) 

) jQuery

###
 