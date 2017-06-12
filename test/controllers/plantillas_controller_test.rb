require 'test_helper'

class PlantillasControllerTest < ActionController::TestCase
  setup do
    @plantilla = plantillas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plantillas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plantilla" do
    assert_difference('Plantilla.count') do
      post :create, plantilla: { descripcion: @plantilla.descripcion, nombre: @plantilla.nombre }
    end

    assert_redirected_to plantilla_path(assigns(:plantilla))
  end

  test "should show plantilla" do
    get :show, id: @plantilla
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plantilla
    assert_response :success
  end

  test "should update plantilla" do
    patch :update, id: @plantilla, plantilla: { descripcion: @plantilla.descripcion, nombre: @plantilla.nombre }
    assert_redirected_to plantilla_path(assigns(:plantilla))
  end

  test "should destroy plantilla" do
    assert_difference('Plantilla.count', -1) do
      delete :destroy, id: @plantilla
    end

    assert_redirected_to plantillas_path
  end
end
