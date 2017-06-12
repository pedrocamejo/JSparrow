require 'test_helper'

class Administracion::UsuariosControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @administracion_usuario = administracion_usuarios(:one)
  end

#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:usuarios)
#  end

#  test "should get new" do
#    get :new
#    assert_response :success
#  end

#  test "should create administracion_usuario" do
#    assert_difference('Administracion::Usuario.count') do
#      post :create,administracion_usuario:{ 
#        username:"RCHIRINOS",  cedula: "V-19827297",
#        nombres: "Rhonal Alfredo",   apellidos: "Chirinos Rodriguez",
#        celular: "04161556613",telefono: "02514897563",
#        direccion: "Barrio el Jebe Sector la Estrella",
#        email: "Rhonalchirinos@gmail.com", password: "123456789",
#        password_confirmation:  "123456789"
#      }
#  #  end

# #   assert_redirected_to administracion_usuario_path(assigns(:administracion_usuario))
#  end

#  test "should show administracion_usuario" do
#    get :show, id: @administracion_usuario
#    assert_response :success
#  end

#  test "should get edit" do
#    get :edit, id: @administracion_usuario
#    assert_response :success
#  end

#  test "should update administracion_usuario" do
#    patch :update, id: @administracion_usuario ,
#       administracion_usuario: { nombres: "ADMIN2" }
    
#    assert_redirected_to administracion_usuario_path(assigns(:administracion_usuario))
#  end

#  test "should destroy administracion_usuario" do
#    assert_difference('Administracion::Usuario.count', -1) do
#      delete :destroy, id: @administracion_usuario
#    end
#    assert_redirected_to administracion_usuarios_path
#  end
end
