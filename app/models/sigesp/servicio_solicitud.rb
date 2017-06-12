class Sigesp::ServicioSolicitud < ActiveRecord::Base
  include PgSearch

	self.primary_key = 'codser'
	self.table_name = 'public.soc_servicios'

	belongs_to :unidad,
		foreign_key: "codunimed",
		class_name: "Sigesp::Unidad"
	
	belongs_to :tipo_servicio,
		foreign_key: "codtipser",
		class_name: "Sigesp::TipoServicio"  
	
	has_and_belongs_to_many :cargos, 
		class_name: "Sigesp::Cargo",
		join_table: "public.soc_serviciocargo",
		foreign_key:"codser",
		association_foreign_key: "codcar"    

  pg_search_scope :search_by_denser,
  	against: :denser,
  	using: {
  	 tsearch: {
  	 	any_word: true,
  	 	prefix: true
  	 	}
  	}


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end


	def cargo_activo
		cargos.first
	end 

	def self.search(page = 1 , search , sort)
	    search ||= ""
   	 	#sort = "soc_servicios.codser" if sort =="codigo"
   	 	#sort = "soc_servicios.denser" if sort == "descripcion"
	    
	    if search.empty? 
	      paginate(page: page).eager_load(:cargos,:unidad,:tipo_servicio).order(:codser) rescue paginate(page: 1).eager_load(:cargos,:unidad,:tipo_articulo)
	    else
	      #paginate(page: page).where("#{sort} like ?","%#{search}%").preload(:cargos,:unidad,:tipo_servicio).order("#{sort} asc")
				case sort 
				when  "codigo"
		      paginate(page: page).where(" soc_servicios.codser like ?","%#{search}%").eager_load(:cargos,:unidad,:tipo_servicio).order(" soc_servicios.codser asc")
					#paginate(page: page).codigo_search(search)
				when "descripcion" 
					paginate(page: page).eager_load(:cargos,:unidad,:tipo_servicio).descripcion_search(search)
				end 
	    end 
	end 

	def self.descripcion_search search
		search_by_denser(search)
	end  

	def self.buscarServicio(codigo)
		servicios = Sigesp::ServicioSolicitud.where("codser like ? ","%#{codigo}%".delete(' '))
		if servicios.size == 0
			nil
		else
			servicios[0]
		end
	end  
 
	self.per_page = 10 
end
