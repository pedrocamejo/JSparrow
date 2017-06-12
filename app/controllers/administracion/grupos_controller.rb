class Administracion::GruposController < ApplicationController
  before_action :set_administracion_grupo, only: [:show, :edit, :update, :destroy]

  # GET /administracion/grupos
  # GET /administracion/grupos.json
  def index
    authorize! :index,Administracion::Grupo
    @grupos = Administracion::Grupo.search params[:page], params[:search], params[:sort]
  end


  # GET /administracion/grupos/1
  # GET /administracion/grupos/1.json
  def show
    authorize! :show,Administracion::Grupo
    @controladores = {}

    @administracion_grupo.permisos.each do |permiso|
      llave = permiso.controlador
      if @controladores.has_key?(llave)
        @controladores[llave] << permiso 
      else
        @controladores[llave] = []
        @controladores[llave] << permiso 
      end 
    end 
  end

  # GET /administracion/grupos/new
  def new
    authorize! :new,Administracion::Grupo
    @administracion_grupo = Administracion::Grupo.new
  end

  # GET /administracion/grupos/1/edit
  def edit
    authorize! :edit,Administracion::Grupo
  end

  # POST /administracion/grupos
  # POST /administracion/grupos.json
  def create
    authorize! :create,Administracion::Grupo
    @administracion_grupo = Administracion::Grupo.new(administracion_grupo_params)

    respond_to do |format|
      if @administracion_grupo.save
        format.html { redirect_to @administracion_grupo, notice: 'Grupo fue creado .' }
        format.json { render action: 'show', status: :created, location: @administracion_grupo }
      else
        format.html { render action: 'new' }
        format.json { render json: @administracion_grupo.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /administracion/grupos/1
  # PATCH/PUT /administracion/grupos/1.json
  def update
    authorize! :update,Administracion::Grupo
    respond_to do |format|
      if @administracion_grupo.update(administracion_grupo_params)
        format.html { redirect_to @administracion_grupo, notice: 'Grupo fue actualizado .' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @administracion_grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracion/grupos/1
  # DELETE /administracion/grupos/1.json
  def destroy
    authorize! :destroy,Administracion::Grupo
    @administracion_grupo.destroy
    respond_to do |format|
      format.html { redirect_to administracion_grupos_url }
      format.json { head :no_content }
    end
  end


  def permisos 
    authorize! :permisos,Administracion::Grupo
    @permiso = nil
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    @controladores = Administracion::Controlador.all
  end 

  def add_permiso
    authorize! :add_permiso,Administracion::Grupo
    @permiso = Administracion::Permiso.find(params[:permiso_id])
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    @grupo.permisos 
    unless @grupo.permisos.find { |permiso| permiso == @permiso } 
      @permiso_grupo = Administracion::PermisoGrupo.new
      @permiso_grupo.grupo = @grupo
      @permiso_grupo.permiso = @permiso
      @permiso_grupo.save 
      flash[:notice] = "Permiso Activado "+@permiso.descripcion
    else
      flash[:notice] = "Este Permiso se Encuentra Asigando "+@permiso.descripcion
    end 
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    @controladores = Administracion::Controlador.all
    render :permisos
    #respond_to do |format|
      #format.html { redirect_to administracion_grupo_permisos_path(@grupo)}
      #format.json { head :no_content }
    #end
  end

  def del_permiso
    authorize! :del_permiso,Administracion::Grupo
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    @permiso = Administracion::Permiso.find(params[:permiso_id])
    @permiso_grupo = @grupo.permiso_grupos.find { |permiso| permiso.permiso == @permiso } 

    unless @permiso_grupo.nil?
      @permiso_grupo.destroy
      flash[:notice] = "Permiso Inactivo"+@permiso.descripcion
    else
      flash[:notice] = "Este Permiso No se Encuentra Asigando"+@permiso.descripcion
    end 

    @grupo = Administracion::Grupo.find(params[:grupo_id])
    @controladores = Administracion::Controlador.all
    render :permisos
    #respond_to do |format|
    #  format.html { redirect_to administracion_grupo_permisos_path(@grupo)}
    #  format.json { head :no_content }
    #end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracion_grupo
      @administracion_grupo = Administracion::Grupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracion_grupo_params
      params.require(:administracion_grupo).permit(:nombre, :estado)
    end
end
