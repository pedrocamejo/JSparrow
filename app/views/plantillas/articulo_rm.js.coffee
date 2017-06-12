
$("#contenido_plantilla").empty().append("<%= escape_javascript render(partial: 'plantillas/articulos', locals: { plantilla: @plantilla } ) %>")
