class Sigesp::ArticuloAlmacen < ActiveRecord::Base
	self.primary_keys = [:codalm, :codart]
	self.table_name = 'public.siv_articuloalmacen'
	belongs_to :almacen , foreign_key: "codalm", class_name: "Sigesp::Almacen"
	belongs_to :articulo, foreign_key: "codart", class_name: "Sigesp::Articulo"

	def nombre_existencia()
		"#{almacen.nomfisalm} -- (#{existencia} )"
	end 

	def self.ArticuloAlmacen(articulo,almacen)
		articulo = find(almacen.id,articulo.id)
	end 
end

