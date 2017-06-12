# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
	
usuario = Administracion::Usuario.new
usuario.username ='administrador'
usuario.cedula = 'V-00000000'
usuario.nombres = 'administrador'
usuario.apellidos = 'administrador'
usuario.celular = 'administrador'
usuario.telefono = 'administrador'
usuario.direccion= 'administrador'
usuario.email= 'administrador@administrador.COM'
usuario.password = '12345678'
usuario.password_confirmation = '12345678'
usuario.save

permisos = Administracion::Permiso.all

permisos.each  do |permiso|
	u = Administracion::PermisoUsuario.new()
	u.usuario = usuario
	u.permiso = permiso 
	u.estado = true
	u.save
end   
  
=end 

#data = {
#	"cod_region" => 1,
#	"cod_sede" => 1,
#	"cod_servicio" => 1 ,
#	"consol" => "asasasdasdasdasd",
#	"articulos_almacen_attributes" => [
#		{ 
#			"codart" => "271121030072708     ",
#			"codalm" => "0000000002",
#			"canart" => 1
#		},
#		{ 
#			"codart" => "271217030300209     ",
#			"codalm" => "0000000002",
#			"canart" => 1
#		},
#		{ 
#			"codart" =>"271121030410005     ",
#			"codalm" => "0000000002",
#			"canart" => 1
#		},
#		{ 
#			"codart" => "411119210910908     ",
#			"codalm" => "0000000001",
#			"canart" => 1
#		},
#		{ 
#			"codart" => "432014020002699     ",
#			"codalm" => "0000000002",
#			"canart" => 1
#		}
#	]
#}

  

data = {"cod_region" => "0004",
	"cod_sede" => "0026",
	"cod_servicio" => "0001",
	"consol" => "890890890",
	"codtipsol" => "01" ,
	"articulos_attributes" => [
		{"codart" => "301016030390174     ","canart" => 22},
		{"codart" => "261017660071840     ","canart" => 50}
	]
}

#solicitud = Sigesp::Solicitud.crear_solicitud_compra(data)
#solicitud.guardar()

solicitud = Sigesp::Solicitud.find("OTI000000000149")

solicitud.actualizar(data)


