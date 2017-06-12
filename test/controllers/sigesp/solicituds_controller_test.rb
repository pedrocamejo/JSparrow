require 'test_helper'

class Sigesp::SolicitudsControllerTest < ActionController::TestCase
  #setup do
  #  @sigesp_solicitud = sigesp_solicituds(:one)
  #end

#  test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:sigesp_solicituds)
#  end

#  test "should get new" do
  #  get :new
  #  assert_response :success
#  end

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

#  test "should show sigesp_solicitud" do
  #  get :show, id: @sigesp_solicitud
  #  assert_response :success
#  end

#  test "should get edit" do
  # get :edit, id: @sigesp_solicitud
  # assert_response :success
 # end

 # test "should update sigesp_solicitud" do
  #  patch :update, id: @sigesp_solicitud, sigesp_solicitud: { ced_bene: @sigesp_solicitud.ced_bene, cod_pro: @sigesp_solicitud.cod_pro, cod_region: @sigesp_solicitud.cod_region, cod_sede: @sigesp_solicitud.cod_sede, cod_servicio: @sigesp_solicitud.cod_servicio, codaprusu: @sigesp_solicitud.codaprusu, codemp: @sigesp_solicitud.codemp, codfuefin: @sigesp_solicitud.codfuefin, codtipsol: @sigesp_solicitud.codtipsol, coduniadm: @sigesp_solicitud.coduniadm, consol: @sigesp_solicitud.consol, destino: @sigesp_solicitud.destino, estapro: @sigesp_solicitud.estapro, estsol: @sigesp_solicitud.estsol, fecaprsep: @sigesp_solicitud.fecaprsep, fechaanula: @sigesp_solicitud.fechaanula, fechaconta: @sigesp_solicitud.fechaconta, fecregsol: @sigesp_solicitud.fecregsol, firnivadm: @sigesp_solicitud.firnivadm, firnivpre: @sigesp_solicitud.firnivpre, firnivsol: @sigesp_solicitud.firnivsol, monbasinm: @sigesp_solicitud.monbasinm, monbasinmaux: @sigesp_solicitud.monbasinmaux, monto: @sigesp_solicitud.monto, montoaux: @sigesp_solicitud.montoaux, montotcar: @sigesp_solicitud.montotcar, montotcaraux: @sigesp_solicitud.montotcaraux, numpolcon: @sigesp_solicitud.numpolcon, numsol: @sigesp_solicitud.numsol, str_codregionsedeservicio: @sigesp_solicitud.str_codregionsedeservicio, tipo_destino: @sigesp_solicitud.tipo_destino, undadm: @sigesp_solicitud.undadm }
  #  assert_redirected_to sigesp_solicitud_path(assigns(:sigesp_solicitud))
 #end

 # test "should destroy sigesp_solicitud" do
  #  assert_difference('Sigesp::Solicitud.count', -1) do
  #    delete :destroy, id: @sigesp_solicitud
  #  end
  #  assert_redirected_to sigesp_solicituds_path
 # end
end
