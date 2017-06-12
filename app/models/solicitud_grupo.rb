class SolicitudGrupo < ActiveRecord::Base
	has_and_belongs_to_many :solicitudes,
		class_name:"Sigesp::Solicitud",
		foreign_key: "grupo_id",
		association_foreign_key: "solicitud_id",
		join_table:"solicitudesgrupos",
		autosave: true

	validates_presence_of :solicitudes

	def self.grupoSolicitud(solicitud)
		SolicitudGrupo.joins(:solicitudes).where('solicitud_id=?',solicitud).uniq()[0]
	end 

	def guardar(unidad,usuario)
        control = Sigesp::CtrlRequisicion.control_compra(unidad)
	   	self.solicitudes.each do |sol|
		    sol.str_codregionsedeservicio="#{sol.region.id}#{sol.sede.id}#{sol.servicio.id}"
		    sol.undadm = unidad['coduac']
		    sol.numsol = control.codigo_solicitud()
		    sol.tipo.numsol =  sol.numsol 
		    sol.usuario = Sigesp::SolicitudUser.solicitudnueva(sol.numsol,usuario) 
	    end 
	    transaction do
	        control.save() 
	        save()
	    end 
	end 

end

