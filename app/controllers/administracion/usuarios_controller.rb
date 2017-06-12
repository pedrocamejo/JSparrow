class Administracion::UsuariosController < ApplicationController

  before_action :set_administracion_usuario, only: [:show, :edit, :update,:destroy,
                :permisos_usuario,:add_permiso_usuario, :del_permiso_usuario,:password_edit,
                 :password_save,:unidades, :agregar_unidad,:quitar_unidad,:grupos,
                 :grupo_catalago,:grupo_add,:grupo_del ]

  before_action :authenticate_usuario!

  # GET /administracion/usuarios
  # GET /administracion/usuarios.json
  def index
    authorize! :index,Administracion::Usuario
    @usuarios = Administracion::Usuario.search params[:page], params[:search], params[:sort]
  end
 
  # GET /administracion/usuarios/1
  # GET /administracion/usuarios/1.json
  def show
    authorize! :show,Administracion::Usuario
  end

  # GET /administracion/usuarios/new
  def new
    authorize! :new,Administracion::Usuario
    @administracion_usuario = Administracion::Usuario.new
  end

  # GET /administracion/usuarios/1/edit
  def edit
    authorize! :edit,Administracion::Usuario
    @administracion_usuario.password_confirmation = @administracion_usuario.password
  end

  def password_edit
    authorize! :password_edit,Administracion::Usuario
  end 

  def password_save
      authorize! :password_save,Administracion::Usuario
      respond_to do |format|
      if @administracion_usuario.update(usuario_params_change_password)
        flash[:notice] = "Usuario Contraseña Actualizada  ."
        format.html { redirect_to @administracion_usuario, notice: 'Usuario Contraseña Actualizada  .' }
        format.json { render action: 'show', status: :created, location: @administracion_usuario}
      else
        format.html { render action: 'password_edit' }
        format.json { render json: @administracion_usuario.errors, status: :unprocessable_entity }
      end
    end

  end 


  # POST /administracion/usuarios
  # POST /administracion/usuarios.json
  def create
    authorize! :create,Administracion::Usuario
    @administracion_usuario = Administracion::Usuario.new(usuario_params)
    @administracion_usuario.password = '12345678'
    @administracion_usuario.password_confirmation= '12345678'
    @administracion_usuario.username = @administracion_usuario.username.upcase 
    respond_to do |format|
      if @administracion_usuario.save
        flash[:notice] = "Usuario Almacenado Correctamente "
        format.html { redirect_to @administracion_usuario }
        format.json { render action: 'show', status: :created, location: @administracion_usuario}
      else
        format.html { render action: 'new' }
        format.json { render json: @administracion_usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracion/usuarios/1
  # PATCH/PUT /administracion/usuarios/1.json
  def update
    authorize! :update,Administracion::Usuario
    respond_to do |format|
      if @administracion_usuario.update(usuario_params_update )
        flash[:notice] = "Usuario fue correctamente actualizado."
        format.html { redirect_to @administracion_usuario}
        format.json { render action: 'show', status: :created, location: @administracion_usuario}
      else
        format.html { render action: 'edit' }
        format.json { render json: @administracion_usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracion/usuarios/1
  # DELETE /administracion/usuarios/1.json
  def destroy
    authorize! :destroy,Administracion::Usuario
    @administracion_usuario.destroy
    respond_to do |format|
      format.html { redirect_to administracion_usuarios_url }
      format.json { head :no_content }
    end
  end

  #Mostrar todo los permisos del usuario 
  def permisos_usuario
    authorize! :permisos_usuario,Administracion::Usuario
    @controladores = Administracion::Controlador.all
  end 
 

  def add_permiso_usuario 
    authorize! :add_permiso_usuario,Administracion::Usuario
    @permiso = Administracion::Permiso.find(params[:permiso_id])
    @administracion_usuario.permisos 
    unless @administracion_usuario.permisos.find { |permiso| permiso == @permiso } 
      @permiso_usuario = Administracion::PermisoUsuario.new
      @permiso_usuario.usuario = @administracion_usuario
      @permiso_usuario.permiso = @permiso
      @permiso_usuario.save 
      flash[:notice] = "Permiso Activado "+@permiso.descripcion
    else
      flash[:notice] = "Este Permiso se Encuentra Asigando "+@permiso.descripcion
    end 
    @controladores = Administracion::Controlador.all
    render :permisos_usuario
  end


  def del_permiso_usuario 
    authorize! :del_permiso_usuario,Administracion::Usuario
    @permiso = Administracion::Permiso.find(params[:permiso_id])
    @permiso_usuario = @administracion_usuario.permiso_usuarios.find {
      |permiso| permiso.permiso == @permiso } 

    unless @permiso_usuario.nil?
      @permiso_usuario.destroy
      flash[:notice] = "Permiso Inactivo"+@permiso.descripcion
    else
      flash[:notice] = "Este Permiso No se Encuentra Asigando"+@permiso.descripcion
    end 
    @controladores = Administracion::Controlador.all
    render :permisos_usuario
  end


  def unidades 
    authorize! :unidades,Administracion::Usuario
    @unidades = Public::SpgMinisterioUa.all 
    @unidades = @unidades - @administracion_usuario.unidades
  end 

  #POST  /administracion/usuarios/:usuario_id/unidad/:unidad_id/quitar(.:format)
  def agregar_unidad
    authorize! :agregar_unidad,Administracion::Usuario
    @unidades = Public::SpgMinisterioUa.all 
    @unidad = Public::SpgMinisterioUa.find(params[:unidad_id])
    unless @administracion_usuario.unidades.exists?(params[:unidad_id])
      @administracion_usuario.unidades << @unidad
      flash[:notice] = "Unidad Agregada Correctamente "
    end 
    @unidades = @unidades - @administracion_usuario.unidades
    render :unidades
  end 

  #POST  /administracion/usuarios/:usuario_id/unidad/:unidad_id/quitar(.:format)
  def  quitar_unidad 
    authorize! :quitar_unidad,Administracion::Usuario
    @unidades = Public::SpgMinisterioUa.all 
    if @administracion_usuario.unidades.exists?(params[:unidad_id])
      @administracion_usuario.unidades.delete params[:unidad_id]
      flash[:notice] = "Unidad quitada Correctamente "
    end 
    @unidades = @unidades - @administracion_usuario.unidades
    render :unidades
  end 


  def grupos 
    authorize! :grupos,Administracion::Usuario
  end 

  # seleccionar usuarios 
  def grupo_catalago
    @grupos = Administracion::Grupo.all
  end 
  
  def grupo_add
    authorize! :grupo_add,Administracion::Usuario
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    unless @administracion_usuario.grupos.exists?(params[:grupo_id])
        @administracion_usuario.grupos << @grupo
        flash[:notice] = "Grupo Asigando Correctamente."
    else
      flash[:error] = "el grupo ya ah sido asignado anteriormente."
    end 
    @grupos = Administracion::Grupo.all
    render :grupos
  end 
  
  def grupo_del 
    authorize! :grupo_del,Administracion::Usuario
    @grupo = Administracion::Grupo.find(params[:grupo_id])
    if @administracion_usuario.grupos.exists?(params[:grupo_id])
        @administracion_usuario.grupos.delete(@grupo)
        flash[:notice] = "Grupo quitado Correctamente."
    else
      flash[:error] = " este usuario no tiene este grupo asociado."
    end 
    @grupos = Administracion::Grupo.all
    render :grupos
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracion_usuario
      if params[:id].nil?
        @administracion_usuario = Administracion::Usuario.find(params[:usuario_id])
      else
        @administracion_usuario = Administracion::Usuario.find(params[:id])
      end
    end

    def usuario_params
      params.require(:administracion_usuario).permit(:cedula, :nombres, :apellidos,:email, :direccion, :telefono, :celular ,:username,:compra)
    end

    def usuario_params_update
      params.require(:administracion_usuario).permit(:nombres, :apellidos,:email, :direccion, :telefono, :celular,:compra)
    end
 
    def usuario_params_change_password
      params.require(:administracion_usuario).permit(:password,:password_confirmation)
    end

    def permiso_edit
      params.require(:permiso).permit(:permis_id)
    end

end
