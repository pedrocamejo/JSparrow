class Sigesp::Articulo < ActiveRecord::Base

  include PgSearch
	self.primary_key = 'codart'
	self.table_name = 'public.siv_articulo'

	belongs_to :unidad, foreign_key: "codunimed", class_name: "Sigesp::Unidad"
	belongs_to :tipo_articulo, foreign_key: "codtipart", class_name: "Sigesp::TipoArticulo"

	has_and_belongs_to_many :cargos, class_name: "Sigesp::Cargo", join_table: "public.siv_cargosarticulo", foreign_key:"codart" ,association_foreign_key: "codcar"

  has_one :enriquecido, foreign_key: "str_codart", class_name: "Sigesp::ArticuloEnriquecido"

	has_many :articulo_almacenes , class_name: "Sigesp::ArticuloAlmacen" , foreign_key: "codart"
	has_many :almacens, class_name: "Sigesp::Almacen" ,  through: :articulo_almacenes 
	
	self.per_page = 12 

  pg_search_scope :search_by_denart, 
  	against: :denart, 
  	using: {
  	 tsearch: {
  	 	#any_word: true,
  	 	prefix: true,
			normalization: 2
  	 	}
  	}

	def cargo_activo
		cargos[0] 
	end 

	CAMPOS_BUSQUEDAD = ["codigo","denominacion","codigofabricante"] 


	def self.search(page = 1,search,sort)
		search ||= ""
		page = 1 if page.to_i.zero?
		if search.empty? or !CAMPOS_BUSQUEDAD.include?(sort)
	    paginate(page: page).detalle().order("denart") #rescue paginate(page: 1).preload(:cargos,:unidad,:tipo_articulo,:enriquecido)
		else 
			case sort 
			when  "codigo"
				paginate(page: page).codigo_search(search)
			when "denominacion" 
				paginate(page: page).descripcion_search(search)
			when "codigofabricante"
				paginate(page: page).codigofabricante_search(search)
			end 
		end 
	end

	def self.tipo_articulo_search(search)
		where(Sigesp::TipoArticulo.a_dentipart.matches("%#{search}%")).detalle()
	end 


	def self.tipo_articulo_codigo_search(search)
		where(codtipart: search).detalle()
	end 

	def  actualizar_ultimo_costo(monpre)
		update(
			ultcosart: monpre,
			cosproart: ((cosproart + monpre) / 2)
		)
	end 

	def self.codigo_search(search)
		where("siv_articulo.codart like ?","%#{search}%").detalle()
	end 

	def self.descripcion_search search
		search_by_denart(search).detalle()
	end  

	def self.codigofabricante_search search
		cadena = search.upcase.split(' ').join('|')
		detalle.where("upper(sigesp_espc.siv_articulo_enriquecido.str_codfabricante) similar to ? ","%(#{cadena})%").
		order("sigesp_espc.siv_articulo_enriquecido.str_codfabricante asc ")
	end 


	def self.detalle()
		eager_load(:cargos,:unidad,:tipo_articulo,:enriquecido)
	end 


	def self.buscarArticulos(codigo)
		articulos = Sigesp::Articulo.where("codart like ? ","%#{codigo}%".delete(' '))
		if articulos.size == 0
			nil
		else
			articulos[0]
		end
	end 

	def self.buscarArticulo(codigo)
		codigo <<  " "*((20-codigo.size).abs)
		Sigesp::Articulo.detalle().find(codigo)
	end 


	def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end
end
