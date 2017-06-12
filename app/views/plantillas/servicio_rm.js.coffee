
$("#contenido_plantilla").empty().append("<%= escape_javascript render(partial: 'plantillas/servicios', locals: { plantilla: @plantilla } ) %>")
