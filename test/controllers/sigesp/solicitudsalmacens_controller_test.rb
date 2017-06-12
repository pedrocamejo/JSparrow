require 'test_helper'

class Sigesp::SolicitudsalmacensControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create sigesp_solicitud" do
    puts 'fofofof'
    post :create, sigesp_solicitud: { 
        ced_bene: "dddasd" }, detalle: { 
         articulos: [{id:1, cantidad: 10, precio:10},
                  {id:2, cantidad: 20, precio:20},
                  {id:3, cantidad: 30, precio:30}]
       }
    puts 'gogogog'
    assert_redirected_to sigesp_solicitud_path(assigns(:sigesp_solicitud))
  end

end
