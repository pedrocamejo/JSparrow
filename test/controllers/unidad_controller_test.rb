require 'test_helper'

class UnidadControllerTest < ActionController::TestCase
  test "should get unidad" do
    get :unidad
    assert_response :success
  end

  test "should get cambiarunidad" do
    get :cambiarunidad
    assert_response :success
  end

end
