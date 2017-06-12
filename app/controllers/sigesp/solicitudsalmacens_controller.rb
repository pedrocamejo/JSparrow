class Sigesp::SolicitudsalmacensController < ApplicationController
	before_action :set_sigesp_solicitud, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_usuario!

  # index_almacen 
  # GET /sigesp/solicituds
  # GET /sigesp/solicituds.json
  def index
    authorize! :index_almacen,Sigesp::Solicitud 
    unidad = session['unidad'] 
    if unidad.nil?
      flash[:error] = "Seleccione una Unidad Funcional "
      redirect_to root_path 
    else
      @sigesp_solicituds = Sigesp::Solicitud.search_almacen(params[:page],params[:search],params[:sort],unidad)
    end 
  end

  # show_almacen
  # GET /sigesp/solicituds/1
  # GET /sigesp/solicituds/1.json
  def show 
    authorize! :show_almacen,Sigesp::Solicitud 
    respond_to do |format|
      format.html {
        @grupo =  SolicitudGrupo.grupoSolicitud(@sigesp_solicitud.numsol)
        if  @grupo.nil?
          @grupo = SolicitudGrupo.new 
          @grupo.solicitudes.append  @sigesp_solicitud
        end 
      }
      format.pdf  do
        @solicitud = Sigesp::Solicitud.find(params[:id])
     end
    end
  end
  
  # new_almacen  
  # GET /sigesp/solicituds/new
  def new
    authorize! :new_almacen,Sigesp::Solicitud 
    @sigesp_solicitud = Sigesp::Solicitud.new
    respond_to do |format|
      format.html
      format.js do 
        @sigesp_solicitud = Sigesp::Solicitud.new(sigesp_solicitud_alamcen_params)
        articulo = Sigesp::DtArticulo.new({numsol: nil, codart: params[:codart],codalm: params[:codalm], canart: 1}) 
        @sigesp_solicitud.agregar_articulo(articulo)
      end 
    end 
  end

  # edit_almacen
  # GET /sigesp/solicituds/1/edit
  def edit
    authorize! :edit_almacen,Sigesp::Solicitud 
    respond_to do |format|
    	format.html do 
		    if @sigesp_solicitud.estsol != 'E'
		      flash[:error] = "No Puede Editar La Requisicion Numero #{@sigesp_solicitud.id}."
		      redirect_to sigesp_solicitudsalmacens_path 
		    end 
		  end
		  format.json { render :show }
    end 
  end


  ############################################
  # create_almacen
  # POST /sigesp/solicituds
  # POST /sigesp/solicituds.json
  def create
    authorize! :create_almacen,Sigesp::Solicitud 
    unidad = session['unidad'] 
    return render json: { unidad: "Esta Unidad Administrativa no tiene Numero de Control " }, status: :unprocessable_entity    if Sigesp::CtrlRequisicion.control_compra(unidad).nil?

    @solicitudes = Sigesp::Solicitud.crear_solicitudes_almacen(sigesp_solicitud_alamcen_params)
    @grupoSolicitud = SolicitudGrupo.new
    @solicitudes.each do |solicitud|
        @grupoSolicitud.solicitudes << solicitud 
    end
    if @grupoSolicitud.valid? 
      @grupoSolicitud.guardar(unidad,current_usuario)
      return render json: { url: sigesp_solicitudsalmacen_path(@grupoSolicitud.solicitudes[0])}  
    else
      return render json:@grupoSolicitud.errors ,status: :unprocessable_entity
    end 
  end



  # update_almacen
  # PATCH/PUT /sigesp/solicituds/1
  # PATCH/PUT /sigesp/solicituds/1.json
  def update
    authorize! :update_almacen,Sigesp::Solicitud
    if @sigesp_solicitud.update(sigesp_solicitud_alamcen_params)
      return render json: { url: sigesp_solicitudsalmacen_path(@sigesp_solicitud)}  
    else
      return render json:@sigesp_solicitud.errors ,status: :unprocessable_entity
    end 
  end

  #anular_almacen 
  def anular
    authorize! :anular_almacen,Sigesp::Solicitud 
    @sigesp_solicitud = Sigesp::Solicitud.find(params[:solicitudsalmacen_id])
    if @sigesp_solicitud.estsol == 'E'
      @sigesp_solicitud.estsol = 'A'
      @sigesp_solicitud.save 
      flash[:notice] = "La Requisicion #{@sigesp_solicitud.id} fue anulada exitosamente."
      redirect_to sigesp_solicitudsalmacen_path(@sigesp_solicitud) 
    else
      flash[:error] = "La Requisicion #{@sigesp_solicitud.id} No Puede ser Anulada."
      redirect_to sigesp_solicitudsalmacens_path 
    end 
  end 

 

  # DELETE /sigesp/solicituds/1
  # DELETE /sigesp/solicituds/1.json
  def destroy

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sigesp_solicitud
      @unidad = session['unidad'] 
      @sigesp_solicitud = Sigesp::Solicitud.find(params[:id])
    end


    def sigesp_solicitud_alamcen_params
      params.require(:solicitud).permit(
          :cod_region,
          :cod_sede,
          :cod_servicio,
          :consol,
          articulos_attributes:[:codart,:codalm,:canart ])
    end

end



 