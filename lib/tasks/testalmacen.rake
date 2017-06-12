namespace :testalmacen do
  desc "TES PARA CREAR UNA SOLICITUD Alamcen "

 
  task crearSolicitudesAlamcen: :environment do
  	parametos_solicitud =  {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"88888888888"}
  	#parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"261115230030873     ","cantidad":"160","almacen":"0000000002"},{"codigo":"491617030003430     ","cantidad":"2","almacen":"0000000001"},{"codigo":"241124040160010     ","cantidad":"2","almacen":"0000000001"},{"codigo":"131015010003240     ","cantidad":"1","almacen":"0000000001"},{"codigo":"311618070171163     ","cantidad":"2","almacen":"0000000001"},{"codigo":"311617180030856     ","cantidad":"22","almacen":"0000000002"}]'}
    parametos_solicitud_detalle ={"detalles"=>''}
  	unidad = {"coduac"=>"00035"}
  	@solicitudes =Sigesp::Solicitud.crear_solicitudes_almacen(parametos_solicitud,parametos_solicitud_detalle)
    grupoSolicitud = SolicitudGrupo.new
    @solicitudes.each do |solicitud|
        grupoSolicitud.solicitudes << solicitud 
    end 
	if grupoSolicitud.valid? 
		grupoSolicitud.guardar(unidad)
    puts "--->#{grupoSolicitud.solicitudes.size}"
		grupoSolicitud.solicitudes.each do |sol|
			puts "--->#{sol.id}"
		end 
		puts "Guardo"
	else
    	puts "#{grupoSolicitud.errors.size}"
    	puts "#{grupoSolicitud.errors.messages}"
    	grupoSolicitud.solicitudes.each do |solicitud|
  	    puts "#{solicitud.errors.messages}"
 	    solicitud.articulos.each do |articulo|
	 	   puts "#{articulo.errors.messages}"
 		   end 
	    end 
		puts "No Guardo "
	end 
  end
    task actualizarSolicitudesAlamcen: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000171')
  	parametos_solicitud =  {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"88888888888"}
  	parametos_solicitud_detalle ={"detalles"=>''}
  	unidad = {"coduac"=>"00035"}
 	  @solicitud.actualizar_solicitud_almacen(parametos_solicitud,parametos_solicitud_detalle)
    puts "cantidad articulos #{@solicitud.articulos.size}"
    if @solicitud.valid?()
	    @solicitud._guardar()
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
    end 
    @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
  end

  task actualizarSolicitudesAlamcen: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000171')
    parametos_solicitud =  {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"88888888888"}
    parametos_solicitud_detalle ={"detalles"=>''}
    unidad = {"coduac"=>"00035"}
    @solicitud.actualizar_solicitud_almacen(parametos_solicitud,parametos_solicitud_detalle)
    puts "cantidad articulos #{@solicitud.articulos.size}"
    if @solicitud.valid?()
      @solicitud._guardar()
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
    end 
    @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
    @solicitud.articulos[0].errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
  end


end



