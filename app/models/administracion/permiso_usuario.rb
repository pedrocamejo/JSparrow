class Administracion::PermisoUsuario < ActiveRecord::Base

	belongs_to :usuario, class_name: "Administracion::Usuario"
	belongs_to :permiso, class_name: "Administracion::Permiso"

	self.per_page = 10 

	def self.search(page = 1 , search , sort)
	    search ||= ""
   	 	sort ||= "" 
	    if search.empty? 
	      paginate(page: page).order(sort) rescue paginate(page: 1) 
	    else
	      paginate(page: page).where("#{sort} like ?","%#{search}%").order("#{sort} asc")
	    end 
	end 
end
