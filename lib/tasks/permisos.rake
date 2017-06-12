namespace :permisos do
  desc "permisos para los Usuarios "
  #################################################################################################################################################################################
  task usuarios: :environment do
  	controlador = Administracion::Controlador.where(subject_class:"Administracion::Usuario").first
		if controlador.nil? # no ah sido ejecutado 
			controlador = Administracion::Controlador.new
			controlador.subject_class = "Administracion::Usuario"
			controlador.descripcion = "Permisos para Usuarios"
	    	controlador.transaction do
				controlador.save 
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'index', descripcion: "Consultar Lista de Usuarios "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'show', descripcion: "Consultar un Usuario "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'new', descripcion: "Crear Usuarios "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'edit', descripcion: "Editar los Datos de los Usuarios "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'create', descripcion: "Guardar los Datos de Usuario Nuevo "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'update', descripcion: "Guardar los Datos Editados de los Usuarios "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'destroy', descripcion: "Eliminar un Usuario "}])
					########################################################################################################################################################	
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'password_edit', descripcion: "editar la contrasena de otros usuarios  "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'password_save', descripcion: "salvar la contrasena de otros usuarios   "}])
					########################################################################################################################################################	
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'permisos_usuario', descripcion: "Visualizar los Permisos "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'add_permiso_usuario', descripcion: "agregar permisos "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion: 'del_permiso_usuario', descripcion: "quitar permisos "}])
					########################################################################################################################################################	
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'unidades', descripcion: "Visualizar las unidades "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'agregar_unidad', descripcion: "agregar unidades "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'quitar_unidad', descripcion: "quitar unidades "}])
					########################################################################################################################################################	
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'grupos', descripcion: "Visualizar los Grupos Asociados "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'grupo_add', descripcion: "agregar grupo "}])
					Administracion::Permiso.create([{ nombre: 'Usuario',controlador: controlador,accion:  'grupo_del', descripcion: "quitar grupo "}])
			end  # end Begin 
  	else
  		puts "Error Controladro #{controlador.subject_class} existente. "
  	end 
  end

 

  task solicitudalmacen: :environment do
  	controlador = Administracion::Controlador.where(subject_class:"Sigesp::Solicitud",descripcion:"Solicitudes de Requisición para Almacen.").first
	if controlador.nil? # no ah sido ejecutado 
			controlador = Administracion::Controlador.new
			controlador.subject_class = "Sigesp::Solicitud"
			controlador.descripcion = "Solicitudes de Requisición para Almacen."
	    	controlador.transaction do
				controlador.save 
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'index_almacen', descripcion: " Listar Requisiciones Almacen"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'show_almacen', descripcion: "Consultar Requisicion Almacen"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'new_almacen', descripcion: "Nueva Requisicion Almacen"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'edit_almacen', descripcion: "Editar Requisicion Almacen "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'create_almacen', descripcion: "Guardar Nueva Requisicion "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'update_almacen', descripcion: "Guardar Cambios de Requisicion Editada "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Almacen',controlador: controlador,accion: 'anular_almacen', descripcion: "Anular Requisicion  "}])
			end  # end Begin 
  	else
  		puts "Error Controladro #{controlador.subject_class} existente. "
  	end 
  end

    task solicitudcompra: :environment do
  	controlador = Administracion::Controlador.where(subject_class:"Sigesp::Solicitud",descripcion:"Solicitudes de Requisición para Compra.").first
	if controlador.nil? # no ah sido ejecutado 
			controlador = Administracion::Controlador.new
			controlador.subject_class = "Sigesp::Solicitud"
			controlador.descripcion = "Solicitudes de Requisición para Compra."
	    	controlador.transaction do
				controlador.save 
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'index_compra', descripcion: " Listar Requisiciones Compra"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'show_compra', descripcion: "Consultar Requisicion Compra"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'new_compra', descripcion: "Nueva Requisicion Compra"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'edit_compra', descripcion: "Editar Requisicion Compra "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'create_compra', descripcion: "Guardar Nueva Requisicion "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'update_compra', descripcion: "Guardar Cambios de Requisicion Editada "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'anular_compra', descripcion: "Anular Requisicion  "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'editarcompra_compra', descripcion: "Editar Precios de Solicitud "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'guardarcompra_compra', descripcion: "Guardar Edicion de Precios de Solicitud"}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'editarpresupuesto_compra', descripcion: "Editar Fuente de Financiamiento de Solicitud "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'guardarpresupuesto_compra', descripcion: "Guardar Fuente de Financiamiento Solicitud "}])

				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'traspasopresupuestario_compra', descripcion: "Traspaso Presupuestario Reporte "}])
				Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'disponibilidadpresupuestaria_compra', descripcion: "Disponibilidad Presupuestaria Reporte "}])

			end  # end Begin 
  	else
  		puts "Error Controladro #{controlador.subject_class} existente. "
  	end 
  end



  #################################################################################################################################################################################
  task grupos: :environment do
  	controlador = Administracion::Controlador.where(subject_class:"Administracion::Grupo").first
		if controlador.nil? # no ah sido ejecutado 
			controlador = Administracion::Controlador.new
			controlador.subject_class = "Administracion::Grupo"
			controlador.descripcion = "Permisos para Grupos"
	    	controlador.transaction do
				controlador.save 
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'index', descripcion: "Consultar Lista de Grupos "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'show', descripcion: "Consultar un Grupo "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'new', descripcion: "Crear Grupo "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'edit', descripcion: "Editar los Datos de los Grupos "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'create', descripcion: "Guardar los Datos de Grupo Nuevo "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'update', descripcion: "Guardar los Datos Editados de los Grupos "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'destroy', descripcion: "Eliminar un Grupo "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'permisos', descripcion: "Visualizar los Permisos "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'add_permiso', descripcion: "agregar permisos "}])
					Administracion::Permiso.create([{ nombre: 'Grupo',controlador: controlador,accion: 'del_permiso', descripcion: "quitar permisos"}])
			end  # end Begin 
  	else
  		puts "Error Controladro #{controlador.subject_class} existente. "
  	end 
  end

  task reversarrequisiciones: :environment do
  	controlador = Administracion::Controlador.where(subject_class:"Sigesp::Solicitud",descripcion:"Solicitudes de Requisición para Compra.").first
	unless controlador.nil? # Esta registrado y lo consiguio 
    	controlador.transaction do
			Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'reversarcompra', descripcion: "Reversar Requisiciones Compra."}])
			Administracion::Permiso.create([{ nombre: 'Solicitud Compra',controlador: controlador,accion: 'reversarpresupuesto', descripcion: "Reversar Requisiciones Presupuesto."}])
		end  # end Begin 
  	else
  		puts "Error Controladro #{controlador.subject_class} Noexistente. "
  	end 
  end

end
 