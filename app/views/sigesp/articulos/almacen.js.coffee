$("#modal-articulos #contenido").empty().append("<%= escape_javascript render( partial: 'sigesp/articulos/articulos_almacen' ) %>")
$("#modal-articulos").modal("show")