require 'test_helper'

class Sigesp::ServicioControllerTest < ActionController::TestCase
  test "should get serviciossolicitud" do
    get :serviciossolicitud
    assert_response :success
  end

end
