require 'test_helper'

class Administracion::UsuariosHelperTest < ActionView::TestCase
	
  test "usuario permiso " do
  	assert_equal 1 , Administracion::Usuario.all.size 
  	usuario = Administracion::Usuario.first
  	controlador = Administracion::Controlador.first
	#assert_equal '<table class=\"table\"><thead><tr><th>Accion </th><th>Descripcion</th><th>Estado</th></tr></thead><tbody><tr><td>show</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>update</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>new</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>edit</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>destroy</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>index</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr><tr><td>create</td><td>Permite Consulta Lista de Usuarios</td><td>Permiso Inactivo </td><td><button class=\"btn btn-default activar_permiso_usuario \">Activar</button></td></tr></tbody></table>',usuario_permiso(controlador,usuario)
  end

end
