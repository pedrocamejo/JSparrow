$("#modal-articulos #contenido").empty().append("<%= escape_javascript render( partial: 'sigesp/articulos/articulos' ) %>")
$("#modal-articulos").modal("show")