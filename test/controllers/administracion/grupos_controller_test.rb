require 'test_helper'

class Administracion::GruposControllerTest < ActionController::TestCase
  setup do
    @administracion_grupo = administracion_grupos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracion_grupos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracion_grupo" do
    assert_difference('Administracion::Grupo.count') do
      post :create, administracion_grupo: { estado: @administracion_grupo.estado, nombre: @administracion_grupo.nombre }
    end

    assert_redirected_to administracion_grupo_path(assigns(:administracion_grupo))
  end

  test "should show administracion_grupo" do
    get :show, id: @administracion_grupo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracion_grupo
    assert_response :success
  end

  test "should update administracion_grupo" do
    patch :update, id: @administracion_grupo, administracion_grupo: { estado: @administracion_grupo.estado, nombre: @administracion_grupo.nombre }
    assert_redirected_to administracion_grupo_path(assigns(:administracion_grupo))
  end

  test "should destroy administracion_grupo" do
    assert_difference('Administracion::Grupo.count', -1) do
      delete :destroy, id: @administracion_grupo
    end

    assert_redirected_to administracion_grupos_path
  end
end
