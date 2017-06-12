namespace :usuariosares do
  desc "Importa todo los usuarios del ares al sistema asignando como su contrasena su numero de cedula "
  task importar: :environment do

	# traerse todolos usuarios 
  	# traerse por usuario las unidades a las que pertenece 
  	#armar el usuario y guardar los cambios 
	def usuario_ares sistema = 7 
	    conectAres = YAML::load_file("config/database.yml")["ares"]
   		coneccion  = PG::Connection.new(host:conectAres['host'],port:conectAres['port'],dbname:conectAres['database'],user:conectAres['username'],password:conectAres['password'])
    	sql = """ select seq_idusuario,str_nombreusuario,str_cedula,str_nombre,str_apellido,str_correo 
    	from tbl_ares_usuario usuario inner join 
    	tbl_ares_usuario_sistema sistema on usuario.seq_idusuario = sistema.int_idusuario 
    	where sistema.int_idsistema = #{sistema}"""

	    puts sql 
    	resultado = coneccion.exec(sql)
    	usuarios = []
	    resultado.each do |r|
	      usuario = {}
	      usuario['id'] = r['seq_idusuario']  
	      usuario['username'] = r['str_nombreusuario']  
	      usuario['cedula'] = r['str_cedula']  
	      usuario['nombre'] = r['str_nombre']  
	      usuario['apellido'] = r['str_apellido']  
	      usuario['correo'] = r['str_correo']  
	      usuarios << usuario 
	    end 
	    usuarios
  	end # end funcion 

    def unidadesfuncionales(id, unidadescargadas)
	    unidades = []
	    conectAres = YAML::load_file("config/database.yml")["ares"]
	    coneccion  = PG::Connection.new(host:conectAres['host'],port:conectAres['port'],dbname:conectAres['database'],user:conectAres['username'],password:conectAres['password'])
	    sql = "select coduac,denuac from viw_usuario_unidades_funcionales where  int_idusuario = #{id}"
	    puts sql 
	    resultado = coneccion.exec(sql)
	    resultado.each do |r|
	      	unidadescargadas.each do |unidad|
	      		if (unidad.coduac == r['coduac'] )
	  		    	unidades.append(unidad)
	  			end 
	  		end 
	    end 
	    #cargo las unidades que existen 
	    unidades
	end  # end unidades funcionales 

	@unidades = Public::SpgMinisterioUa.all

	usuarios = usuario_ares()
	usuarios.each do |usuario|
		if Administracion::Usuario.get_usuario(usuario['cedula']).nil?
			# creamos un nuevo usuario 
			@usuario = Administracion::Usuario.new()
   	 		@usuario.password = '12345678'
    		@usuario.password_confirmation= '12345678'
			@usuario.username = usuario['username']
			@usuario.cedula  = usuario['cedula'] 
			@usuario.nombres   = usuario['nombre']
		    @usuario.apellidos = usuario['apellido'] 
		    @usuario.email = 	usuario['correo']  
		    # unidades asociadas 
		    unidades = unidadesfuncionales(usuario['id'],@unidades)
		    # aasicoar y guardar 
		    @usuario.transaction do 
			    @usuario.save
			    unidades.each do |unidad|
			    	@usuario.unidades << unidad 
			    end 
			end 
			"error usuario #{@usuario.cedula} " if @usuario.errors.size != 0 
		end 
	end 
  end

end
