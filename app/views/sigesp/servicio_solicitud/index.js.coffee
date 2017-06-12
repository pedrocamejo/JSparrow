$("#modal-articulos #contenido").empty().append("<%= escape_javascript render( partial: 'sigesp/servicio_solicitud/servicio' ) %>")
$("#modal-articulos").modal("show")