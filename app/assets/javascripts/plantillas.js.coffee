# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
modal = Object()


$(document).on 'click', '.add_detalle_plantilla  .cargar_articulo ', (e) ->
	url = $(this).data("url")   
	contenedor = $('<div>',{ class: "modal-body seleccionar_articulo" })
	divTabla = $('<div>',{class:"contArticulo"})
	data = 
		url: url
		type: 'get'
		dataType: 'HTML'
		success: (data) ->
			divTabla.empty()
			divTabla.append data 
			return 
	$.ajax data
	contenedor.append divTabla 
	header = $.aplicacion.crearHear("seleccionar articulo")
	modal  = $.aplicacion.crearVentana header,contenedor, $.aplicacion.footer(null,null)
	modal.modal('show',{keyboard: false })
	return  


$(document).on 'click', '.detalle .quitararticulo_plantilla', (e) ->
 $(this).parent().parent().remove()

quitar = (tr) ->
		span = $('<span>',{"class":"glyphicon glyphicon-minus quitararticulo_plantilla","aria-hidden":"true"})
		td = $('<td>').append span 
		td 

#########################Seleccionar el articulo de la lista   
$(document).on 'click', '.seleccionar_articulo .articulos .articulo', (e) ->
	e.preventDefault()
	codigo = $(this).data('codigo').trim()
	encontrado = ($(document).find('#'+codigo).length != 0)  
	if(encontrado)
		 alert "Articulo Cargado "
	else
		tr = $('<tr>',{id:codigo})        
		tr.append $('<td>').append(codigo)
		tr.append $('<td>').append($(this).data('denom'))
		tr.append $('<td>').append($(this).data('unidad'))
		tr.append quitar(tr)
		$('.detalle').append tr
		modal.modal('hide')
		modal.detach()



productos_articulos =()->
	lista = []
	$('.detalle tr').each (index)->
		articulo = {} 
		articulo.codigo = this.id 
		lista.push articulo
	lista 


$(document).on 'click', '.plantilla_editar .plantilla_guardar_articulo', (e) ->
  detalles = JSON.stringify(productos_articulos())
  if detalles.length == 0
    alert 'Debes Agregar por lo menos 1 articulo '
  else
    url = $(this).data('url')
    informacion = articulos: detalles
    data =
      url: url
      type: 'POST'
      dataType: 'JSON'
      data: informacion
      success: (data) ->
	      $(location).attr('href',data.url);
	      return 
    return $.ajax(data)
  return


$(document).on 'click', '.plantilla_editar .plantilla_guardar_servicio', (e) ->
  detalles = JSON.stringify(productos_articulos())
  if detalles.length == 0
    alert 'Debes Agregar por lo menos 1 articulo '
  else
    url = $(this).data('url')
    informacion = servicios: detalles
    data =
      url: url
      type: 'POST'
      dataType: 'JSON'
      data: informacion
      success: (data) ->
	      $(location).attr('href',data.url);
	      return 
    return $.ajax(data)
  return


#########################Seleccionar el articulo de la lista   
$(document).on 'click', '.seleccionar_articulo .servicios .servicio', (e) ->
	e.preventDefault()
	codigo = $(this).data('codigo').trim()
	encontrado = ($(document).find('#'+codigo).length != 0)  
	if(encontrado)
		 alert "Servicio Cargado "
	else
		tr = $('<tr>',{id:codigo})        
		tr.append $('<td>').append(codigo)
		tr.append $('<td>').append($(this).data('denom'))
		tr.append $('<td>').append($(this).data('unidad'))
		tr.append quitar(tr)
		$('.detalle').append tr
		modal.modal('hide')
		modal.detach()


