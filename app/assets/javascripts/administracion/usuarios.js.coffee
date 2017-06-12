# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'submit', '.formulariousuario_nuevo form', (e) ->
  form = $('.formulariousuario_nuevo form')
  data =
    url: form.attr('action')
    type: 'post'
    data: $(this).serialize()
    dataType: 'JSON'
    success: (data) ->
      $(location).attr('href',$('.formulariousuario_nuevo').attr('url')+"/"+data.id);
      return 
    error: (obj) ->
      $('#administracion_usuario_cedula').campo_error(obj.responseJSON.cedula)
      $('#administracion_usuario_email').campo_error(obj.responseJSON.email)
      $('#administracion_usuario_nombres').campo_error(obj.responseJSON.nombres)
      $('#administracion_usuario_apellidos').campo_error(obj.responseJSON.apellidos)
      $('#administracion_usuario_username').campo_error(obj.responseJSON.username)
      return
  $(".erro_campo").remove()
  $.ajax data
  e.preventDefault()
  return


$(document).on 'submit', '.formulariousuario_contrasena form', (e) ->
  form = $('.formulariousuario_contrasena form')
  data =
    url: form.attr('action')
    type: 'post'
    data: $(this).serialize()
    dataType: 'JSON'
    success: (data) ->
      $(location).attr('href',$('.formulariousuario_contrasena').attr('url')+"/"+data.id);
      return 
    error: (obj) ->
      $('#administracion_usuario_password').campo_error(obj.responseJSON.password)
      $('#administracion_usuario_password_confirmation').campo_error(obj.responseJSON.password_confirmation)
      return
  $(".erro_campo").remove()
  $.ajax data
  e.preventDefault()
  return

 