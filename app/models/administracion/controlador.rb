class Administracion::Controlador < ActiveRecord::Base

   has_many  :permisos , class_name: "Administracion::Permiso"

end
