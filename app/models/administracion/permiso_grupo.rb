class Administracion::PermisoGrupo < ActiveRecord::Base
  belongs_to :permiso , class_name: "Administracion::Permiso"
  belongs_to :grupo  , class_name: "Administracion::Grupo" 
end
