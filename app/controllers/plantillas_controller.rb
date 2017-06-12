class PlantillasController < ApplicationController
  before_action :set_plantilla, only: [:show, :edit, :update, :destroy,:articulo_add,:servicio_add,:articulo_rm,:servicio_rm,:articulos,:servicios]

  # GET /plantillas
  # GET /plantillas.json
  def index
    @plantillas = Plantilla.search(params[:page], params[:search], params[:sort])
  end

  # GET /plantillas/1
  # GET /plantillas/1.json
  def show
  end

  # GET /plantillas/new
  def new
    @plantilla = Plantilla.new
  end

  # GET /plantillas/1/edit
  def edit
  end

  def articulos
    @articulos = Sigesp::Articulo.search(params[:page], params[:search], params[:sort])
  end 

  def servicios
    @servicios = Sigesp::ServicioSolicitud.search(params[:page], params[:search], params[:sort])
  end 

  def articulo_add
    @articulo = Sigesp::Articulo.find(params[:articulo_id])
    @plantilla.articulos_add(@articulo)
  end 

  def servicio_add
    @servicio = Sigesp::ServicioSolicitud.find(params[:servicio_id])
    @plantilla.servicios_add(@servicio)
  end 

  def articulo_rm
    @articulo = Sigesp::Articulo.find(params[:articulo_id])
    @plantilla.articulos_rm(@articulo)
  end 

  def servicio_rm
    @servicio = Sigesp::ServicioSolicitud.find(params[:servicio_id])
    @plantilla.servicios_rm(@servicio)
  end 


  # POST /plantillas
  # POST /plantillas.json
  def create
    @plantilla = Plantilla.new(plantilla_params)
    respond_to do |format|
      if @plantilla.save
        format.html { redirect_to @plantilla, notice: 'la Plantilla fue creada exitosamente.' }
        format.json { render action: 'show', status: :created, location: @plantilla }
      else
        format.html { render action: 'new' }
        format.json { render json: @plantilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plantillas/1
  # PATCH/PUT /plantillas/1.json
  def update
    respond_to do |format|
      if @plantilla.update(plantilla_params_edit)
        format.html { redirect_to @plantilla, notice: 'Plantilla fue actualizada exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plantilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plantillas/1
  # DELETE /plantillas/1.json
  def destroy
    @plantilla.destroy
    respond_to do |format|
      format.html { redirect_to plantillas_url , notice: 'Plantilla Eliminada ' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plantilla
      @plantilla = Plantilla.find(params[:id] || params[:plantilla_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plantilla_params
      params.require(:plantilla).permit(:nombre, :descripcion,:tipo,:compra)
    end

    def plantilla_params_edit
      params.require(:plantilla).permit(:nombre, :descripcion)
    end
 
end


