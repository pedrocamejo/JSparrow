namespace :test do
  desc "TES PARA CREAR UNA SOLICITUD TEIPO COMPRA "
  task crearSolicitudCompra: :environment do
  	parametos_solicitud = {"codtipsol"=>"01", "cod_region"=>"0002",
  		"cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"88888888888"}
  	parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"261115120172634","cantidad":"10"}]'}
  	unidad = {"coduac"=>"00035"}
    @solicitud =Sigesp::Solicitud.crear_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud.valid?()
    @solicitud._guardar(unidad)
    @solicitud.errors.full_messages.each do |mensaje|
		puts "#{mensaje} <-----"
  	end 
    @solicitud.articulos[0].errors.full_messages.each do |mensaje|
    puts "#{mensaje} <-----"
    end 
    puts "#{@solicitud.id}"
  end


  task actualizarSolicitudCompra2: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000088')
    puts "cantidad articulo: #{@solicitud.articulos.size}"
    parametos_solicitud = {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"261115120172634","cantidad":"1240"},{"codigo":"441031030550002","cantidad":"10"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
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

  task actualizarSolicitudCompra: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000088')
    puts "cantidad articulo[0]: #{@solicitud.articulos[0]}"
    puts "consol : #{@solicitud.consol}"
    parametos_solicitud = {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"261115120172634","cantidad":"40"},{"codigo":"441031030550002","cantidad":"1.0"},{"codigo":"441031030550004","cantidad":"1.0"},{"codigo":"441031030550010","cantidad":"24"},{"codigo":"441031030001001","cantidad":"22"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad articulos #{@solicitud.articulos.size}"

    if @solicitud.valid?()
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


  task actualizarSolicitudCompraCargo: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000088')
    puts "cantidad articulo[0]: #{@solicitud.articulos[0].canart}"
    puts "consol : #{@solicitud.consol}"
    parametos_solicitud = {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"441031030550005","cantidad":"1.0","precio":"1.0","total":"1.0","cargo":"00385"},{"codigo":"441031030550002","cantidad":"1.0","precio":"1.0","total":"1.0","cargo":"00385"},{"codigo":"441031030550004","cantidad":"1.0","precio":"1.0","total":"1.0","cargo":"00385"},{"codigo":"441031030550010","cantidad":"2.0","precio":"2500.0","total":"5000.0","cargo":"00001"},{"codigo":"441031030001001","cantidad":"2.0","precio":"17.0","total":"34.0","cargo":"00002"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad articulos #{@solicitud.articulos.size}"

    if @solicitud.valid?()
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


  task actualizarSolicitudCompraCargo1: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000088')
    puts "cantidad articulos #{@solicitud.articulos.size}"
    parametos_solicitud = {"codtipsol"=>"01", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"441031030550005","cantidad":"1.0","precio":"1.0","total":"1.0","cargo":"00385"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad articulos #{@solicitud.articulos.size}"

    if @solicitud.valid?()
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

  ##########################################################################################################

   task crearSolicitudCompraServicio: :environment do
    parametos_solicitud = {"codtipsol"=>"02", "cod_region"=>"0002",
      "cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"88888888888"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"0000000079","cantidad":"2"},{"codigo":"0000000093","cantidad":"2"},{"codigo":"0000000095","cantidad":"2"}]'}
    unidad = {"coduac"=>"00035"}
    @solicitud =Sigesp::Solicitud.crear_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    puts "#{@solicitud.servicios_cargos}"
    
    if @solicitud.valid?()
      @solicitud._guardar(unidad)
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
      @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
      end 
      @solicitud.servicios[0].errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
      end 
      puts "#{@solicitud.id}"
    end 


  end


  task actualizarSolicitudCompraServicio: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000092')
    puts "cantidad servicios: #{@solicitud.servicios.size}"
    parametos_solicitud = {"codtipsol"=>"02", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"0000000079","cantidad":"2"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad servicios #{@solicitud.servicios.size}"

    if @solicitud.valid?()
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
    end 
    @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
    @solicitud.servicios[0].errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
  end
 

  task actualizarSolicitudCompraServicioCargo: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000092')
    puts "cantidad servicios: #{@solicitud.servicios.size}"
    parametos_solicitud = {"codtipsol"=>"02", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"0000000157","cantidad":"1.0","precio":"12","total":"12","cargo":"00482"},{"codigo":"0000000090","cantidad":"2","precio":"2","total":"4","cargo":"00002"},{"codigo":"0000000095","cantidad":"2","precio":"2","total":"4","cargo":"00002"},{"codigo":"0000000088","cantidad":"2","precio":"2","total":"4","cargo":"00002"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad servicios: #{@solicitud.servicios.size}"

    if @solicitud.valid?()
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
    end 
    @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
    @solicitud.servicios[0].errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 

  end 


  task actualizarSolicitudCompraServicioCargo1: :environment do
    @solicitud = Sigesp::Solicitud.find('OTI000000000090')
    puts "cantidad servicios: #{@solicitud.servicios.size}"
    parametos_solicitud = {"codtipsol"=>"02", "cod_region"=>"0002","cod_sede"=>"0003","cod_servicio"=>"0002", "consol"=>"Soy el nuevo detalle"}
    parametos_solicitud_detalle ={"detalles"=>'[{"codigo":"0000000079","cantidad":"2.0"},{"codigo":"0000000093","cantidad":"2.0"},{"codigo":"0000000095","cantidad":"2.0"}]'}
    @solicitud.actualizar_solicitud_compra(parametos_solicitud,parametos_solicitud_detalle)
    @solicitud._guardar()
    puts "cantidad servicios: #{@solicitud.servicios.size}"
    if @solicitud.valid?()
      puts "Solicitud Actualizada "
    else
      puts "Solicitud NO Actualizada "
    end 
    @solicitud.errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
    @solicitud.servicios[0].errors.full_messages.each do |mensaje|
      puts "#{mensaje} <-----"
    end 
  end 


 
end



