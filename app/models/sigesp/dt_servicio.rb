class Sigesp::DtServicio < ActiveRecord::Base
	self.primary_keys = [:codemp,:numsol,:codser]
	self.table_name = 'public.sep_dt_servicio'

	belongs_to :solicitud,
        foreign_key: "numsol",
        class_name: "Sigesp::Solicitud"

	belongs_to :servicio,
        foreign_key: "codser",
        class_name: "Sigesp::ServicioSolicitud"


    has_one :cargo , class_name: "Sigesp::DtsCargo",
    foreign_key: [:codemp,:numsol,:codser],
    autosave: true,
    dependent: :destroy 


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end

    validates :solicitud,presence: {message: 'Seleccione '}
    validates :servicio,presence: {message: 'Seleccione '}
    validates :canser,presence: {message: 'Ingrese '}
    validates :canser, numericality: {greater_than:0,message: 'Ingrese cantidad '}
 

#    def self.perteneceServicio(servicios,codser,numsol)
#        codser = codser.delete(' ') unless codser.nil?
#        numsol = numsol.delete(' ') unless numsol.nil?
#        servicios.each do |ser|
#            if ser.codser == codser and ser.numsol == numsol 
#                return ser
#            end 
#        end
#        nil
#        #if servicios.exists?(codemp:"0001",numsol:numsol,codser: codser)
#        #   servicios.where(codemp:"0001",numsol:numsol,codser: codser)[0]
#        #else 
#        #    nil
#        #end 
#    end 

#    def self.buscarCargoServicio(servicios_cargos,codser,numsol,codcar)
#        codser = codser.delete(' ') unless codser.nil?
#        numsol = numsol.delete(' ') unless numsol.nil?
#        codcar = codcar.delete(' ') unless codcar.nil?
#
#        servicios_cargos.each do |car|
#            if car.codser.delete(' ') == codser and car.numsol == numsol and car.codcar == codcar
#                return car
#            end 
#        end 
#        nil
# 
#    end 



#    #retorna listado de articulos no presentes
#    #articulos presentes en la solicitud y no en el detalle
#    # es necesario eliminar esos articulos 
#    def self._serviciosCompra(solicitud,detalle) # por que no hacer el cargo de una vez 
#        #total en dinero 
#        monto  = 0.0 
#        monbasinm= 0.0
#        montotcar = 0.0
#        JSON.parse(detalle["detalles"]).each do |detalle|
#            servicio =  Sigesp::ServicioSolicitud.buscarServicio(detalle["codigo"])
#            cantidad = detalle["cantidad"].to_f
#            precio =  detalle["precio"].to_f
#            dtservicio = perteneceServicio(solicitud.servicios,detalle["codigo"],solicitud.numsol)
#            if dtservicio.nil?
#                dtservicio = Sigesp::DtServicio.new()
#                dtservicio.solicitud = solicitud
#                dtservicio.codemp = "0001"
#                dtservicio.numsol = solicitud.numsol
#                dtservicio.servicio =servicio 
#                dtservicio.canser = cantidad
#                dtservicio.monser = precio * cantidad 
#                dtservicio.monpre = precio
#                dtservicio.orden = 0 
#                dtservicio.codestpro1 = "00000000000000000000"
#                dtservicio.codestpro2 = "000000"
#                dtservicio.codestpro3 = "000"
#                dtservicio.codestpro4 = "00"
#                dtservicio.codestpro5 = "00"
#                dtservicio.spg_cuenta = servicio.spg_cuenta.delete(' ')
#                ############################# CARGO NUEVO 
#                dtcargo = Sigesp::DtsCargo._cargo_nuevo(solicitud,servicio,precio,cantidad,detalle["cargo"])
#                montotcar += dtcargo.monimp
#                monbasinm += dtcargo.monto
#                monto += dtcargo.monbasimp
#                solicitud.servicios << dtservicio 
#                solicitud.servicios_cargos << dtcargo 
# 
#                solicitud.servicios_aux << dtservicio 
#                solicitud.servicios_cargos_aux << dtcargo 
#            else # actualizar la cantidad 
#                dtservicio.canser= cantidad
#                dtservicio.monser = precio * cantidad 
#                dtservicio.monpre = precio
#                #CARGO actualizar 
#                dtcargo = buscarCargoServicio(solicitud.servicios_cargos,detalle["codigo"],solicitud.numsol,servicio.cargo_activo.codcar)
#                dtcargo.monbasimp =(cantidad * precio)
#                dtcargo.monimp = (cantidad * precio) * (dtcargo.cargo.porcar/100) unless dtcargo.cargo.nil?
#                dtcargo.monto = dtcargo.monbasimp + dtcargo.monimp
#                montotcar += dtcargo.monimp
#                monbasinm += dtcargo.monto
#                monto += dtcargo.monbasimp
#                solicitud.servicios_aux << dtservicio 
#                solicitud.servicios_cargos_aux << dtcargo 
#            end     
#        end  #end JSON PARSE
#        solicitud.monto  = monto 
#        solicitud.monbasinm= monbasinm
#        solicitud.montotcar = montotcar
#        puts "----> #{solicitud.monto} --- #{solicitud.monbasinm} --- #{solicitud.montotcar} <-----"
#        solicitud
#    end 
  
end
