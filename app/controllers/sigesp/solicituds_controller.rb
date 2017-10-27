class Sigesp::SolicitudsController < ApplicationController
 before_action :set_sigesp_solicitud, only: [:show, :edit, :update, :destroy]

 before_action :authenticate_usuario!

 # GET /sigesp/solicituds
 # GET /sigesp/solicituds.json
  def index
    logger.info "Processing the request..."
    authorize! :index_compra,Sigesp::Solicitud 
    if current_usuario.compra?
      unidad = Public::SpgMinisterioUa.ninguno(params[:unidad])
    else
      unidad = session['unidad'] 
    end 
    @sigesp_solicituds = Sigesp::Solicitud.search_compra(params[:page], params[:search], params[:sort],unidad)
  end

  # GET /sigesp/solicituds/1
  # GET /sigesp/solicituds/1.json
  def show
    authorize! :show_compra,Sigesp::Solicitud 
  end

  # GET /sigesp/solicituds/new
  def new
    authorize! :new_compra,Sigesp::Solicitud 
    if params[:plantilla_id].nil? 
      @solicitud = Sigesp::Solicitud.new 
      @solicitud.codtipsol = params[:codtipsol]
    else
      @solicitud = Sigesp::Solicitud.crear_solicitud_plantilla(params[:plantilla_id]) 
    end 
    unidad = session['unidad'] 
    if unidad.nil?
      flash[:error] = "Seleccione una Unidad Funcional "
      redirect_to root_path 
    end 
  end

  # GET /sigesp/solicituds/1/edit
  def edit
    authorize! :edit_compra,Sigesp::Solicitud 
    if @solicitud.estsol != 'E'
      flash[:error] = "No Puede Editar La Requisicion Numero #{@solicitud.id}."
      redirect_to sigesp_solicituds_path 
    end 

  end

  def create
    authorize! :create_compra,Sigesp::Solicitud 
    unidad = session['unidad'] 
    @solicitud =Sigesp::Solicitud.crear_solicitud_compra(sigesp_solicitud_params)
    if @solicitud.guardar(unidad,current_usuario)
      return render  :show
    else
      return render json:@solicitud.errors ,status: :unprocessable_entity
    end 
  end

  # PATCH/PUT /sigesp/solicituds/1
  # PATCH/PUT /sigesp/solicituds/1.json
  def update
    authorize! :update_compra,Sigesp::Solicitud 
    @solicitud.actualizar(sigesp_solicitud_params)
    if @solicitud.errors.empty?
      return render  :show
    else
      return render json:@solicitud.errors ,status: :unprocessable_entity
    end 
  end

  # DELETE /sigesp/solicituds/1
  # DELETE /sigesp/solicituds/1.json
  def destroy
    authorize! :anular_compra,Sigesp::Solicitud 
    if @solicitud.estsol == 'E'
      @solicitud.estsol = 'A'
      @solicitud.save 
      flash[:notice] = "La Requisicion #{@solicitud.id} fue anulada exitosamente."
      redirect_to sigesp_solicitud_path(@solicitud) 
    else
      flash[:error] = "La Requisicion #{@solicitud.id} No Puede ser Anulada."
      redirect_to sigesp_solicituds_path 
    end 
 
  end

  def editarcompra
    authorize! :editarcompra_compra,Sigesp::Solicitud 
     @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    unless @solicitud.estsol == 'E' # or @solicitud.estsol == 'P'
      flash[:error] = "No Puede Editar La Requisicion Numero #{@solicitud.id}."
      redirect_to sigesp_solicituds_path 
    end 
  end 
  
  def guardarcompra 
    authorize! :guardarcompra_compra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    @solicitud.estsol='P'
    @solicitud.actualizar(sigesp_solicitud_params_compra)
    if @solicitud.errors.empty?
      return render  :show
    else
      return render json:@solicitud.errors ,status: :unprocessable_entity
    end 
  end 

  def reversarcompra
    authorize! :reversarcompra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    unless @solicitud.estsol == 'P'
      flash[:error] = "No Puede Reversar La Requisicion Numero #{@solicitud.id}."
      redirect_to sigesp_solicituds_path 
    else
      @solicitud.estsol='E' 
      @solicitud.save()
      flash[:notice] = "Estado Cambiado "
      render :show 
    end 
  end 

  def editarpresupuesto
    authorize! :editarpresupuesto_compra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    unless @solicitud.estsol == 'E' or @solicitud.estsol == 'P'
      flash[:error] = "No Puede Editar La Requisicion Numero #{@solicitud.id}."
      redirect_to sigesp_solicituds_path 
    end 
  end 


  def guardarpresupuesto
    authorize! :guardarpresupuesto_compra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    parametros = sigesp_solicitud_params_presupuesto
    parametros[:estsol]='C' 
    respond_to do |format|
      if @solicitud.actualizar_fuentefinanciamiento(parametros,sigesp_solicitud_params_presupuesto_codestpro)
        flash[:notice] = "Fuente de Financiamiento y Unidad Administrativa Asignada "
        format.html { redirect_to @solicitud  }
        format.json { render :show, status: :ok, location: @celula_celula }
      else
        format.html { render :editarpresupuesto }
        format.json { render json: @solicitud.errors, status: :unprocessable_entity }
      end
    end 
  end 


  def reversarpresupuesto
    authorize! :reversarpresupuesto,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    unless @solicitud.estsol == 'C'
      flash[:error] = "No Puede Reversar La Requisicion Numero #{@solicitud.id}."
      redirect_to sigesp_solicituds_path 
    else
      @solicitud.estsol='P' 
      @solicitud.save()
      flash[:notice] = "Estado Cambiado "
      render :show 
    end 
  end 



  def traspasopresupuestario
    authorize! :traspasopresupuestario_compra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    respond_to do |format|
      format.pdf 
    end
  end 
 
  def disponibilidadpresupuestaria
    authorize! :disponibilidadpresupuestaria_compra,Sigesp::Solicitud 
    @solicitud = Sigesp::Solicitud.find(params[:solicitud_id])
    respond_to do |format|
      format.pdf 
    end
  end  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sigesp_solicitud
      @solicitud = Sigesp::Solicitud.find(params[:id])
    end


    def sigesp_solicitud_params_presupuesto
      params.require(:sigesp_solicitud).permit(:coduniadm,:codfuefin,)
    end 

    def sigesp_solicitud_params_presupuesto_codestpro
      params.permit(:codestpro1,:codestpro2,:codestpro3,:codestpro4,:codestpro5)
    end 

    def sigesp_solicitud_params
      params.require(:solicitud).permit(
        :cod_region,
        :cod_sede,
        :cod_servicio,
        :consol,
        :codtipsol,
        articulos_attributes: [:codart,:canart ],
        servicios_attributes: [:codser,:canser ])
    end

    def sigesp_solicitud_params_compra
      params.require(:solicitud).permit(
        :cod_region,
        :cod_sede,
        :cod_servicio,
        :consol,
        :porcar,
        :codtipsol,
        articulos_attributes: [:codart,:canart,:monpre],
        servicios_attributes: [:codser,:canser,:monpre])
    end

end
 