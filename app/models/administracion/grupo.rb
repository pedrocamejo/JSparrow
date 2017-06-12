class Administracion::Grupo < ActiveRecord::Base

   has_many  :permiso_grupos , class_name: "Administracion::PermisoGrupo"
   has_many  :permisos, through: :permiso_grupos , class_name: "Administracion::Permiso"
   has_and_belongs_to_many :usuarios


  def self.search(page = 1 , search , sort)
    search ||= ""
    sort ||= "" 

    if search.empty? 
      paginate(page: page).order(sort) rescue paginate(page: 1) 
    else
      paginate(page: page).where("#{sort} like ?","%#{search}%").order("#{sort} asc")
    end 
  end 
  
 
  validates :nombre,
      presence: {message: 'Ingrese Su Nombre '},
      length: {maximum: 30, too_long:"%{count} caracteres es el maximo  "}

  validates :estado,
      presence: {message: 'Ingrese el estado '}


	self.per_page = 10 
end
