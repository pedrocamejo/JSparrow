class Plantilla < ActiveRecord::Base

  has_and_belongs_to_many :articulos, 
    class_name: "Sigesp::Articulo",
    join_table: "gorrion.articulos_plantillas"
  
  has_and_belongs_to_many :servicios,
    class_name: "Sigesp::ServicioSolicitud",
    join_table: "gorrion.plantillas_servicios",
    association_foreign_key: "servicio_id"    

  def self.search(page = 1,search=nil,sort=nil)
    search ||= "" 
    sort ||= "" 
    if search.empty? 
        paginate(page:page).order(sort) 
    else
        where = "#{sort} like :search "
        paginate(page:page).where(where,{search:"%#{search}%"}).order(sort)
    end 
  end 

  def articulos_add articulo 
    self.articulos << articulo unless self.articulos.include?(articulo)
  end 

  def articulos_rm articulo 
    self.articulos.delete(articulo) if self.articulos.include?(articulo)
  end 

  def servicios_add servicio 
    self.servicios << servicio unless self.servicios.include?(servicio)
  end 

  def servicios_rm servicio 
    self.servicios.delete(servicio) if self.servicios.include?(servicio)
  end 

  self.per_page = 10 
end




