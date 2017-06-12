$("#new_solicitud").
	replaceWith(" <%= escape_javascript render('form',solicitud: @sigesp_solicitud, url: sigesp_solicitudsalmacens_path) %>")