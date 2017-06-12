Gorrion::Application.routes.draw do
  
  resources  :plantillas  do 
#    get :detalle 
#    get :catalogo , on: :collection
#    get :articulos

    get "articulos/add",to: "plantillas#articulos", as: :articulos 
    get "servicios/add",to: "plantillas#servicios", as: :servicios

    post "articulos/add",to: "plantillas#articulo_add", as: :articulo_add
    post "servicios/add",to: "plantillas#servicio_add", as: :servicio_add

    delete "servicios/:servicio_id",to: "plantillas#servicio_rm", as: :servicio_rm
    delete "articulos/:articulo_id",to: "plantillas#articulo_rm", as: :articulo_rm
  end 

  devise_for :usuarios,class_name: "Administracion::Usuario", controllers: {
     sessions: 'usuarios/sessions',
  }

  get :passwords, to: 'usuarios/passwords#new' 
  patch "passwords/update", to: 'usuarios/passwords#update' 

  scope  :unidad do
    get 'unidad/', to:'unidad#unidad',  as: :unidad_index
    post 'cambiar/', to:'unidad#cambiarunidad' , as: :unidad_cambiar  
  end

  namespace :administracion do
    resources :grupos do 
        get  :permisos 
        post 'permiso/:permiso_id/add/', to: 'grupos#add_permiso' , as: :permiso_add
        post 'permiso/:permiso_id/del/', to: 'grupos#del_permiso', as: :permiso_del 
    end 

    resources :usuarios do        
        get :unidades 
        post "unidad/:unidad_id/agregar" , to: 'usuarios#agregar_unidad', as: :agregar_unidad
        post "unidad/:unidad_id/quitar" , to: 'usuarios#quitar_unidad', as: :quitar_unidad

        get  'permisos', to: 'usuarios#permisos_usuario'
        post 'permiso/:permiso_id/add/', to: 'usuarios#add_permiso_usuario' , as: :permiso_add
        post 'permiso/:permiso_id/del/', to: 'usuarios#del_permiso_usuario', as: :permiso_del 
        get  'password' , to: 'usuarios#password_edit'
        patch 'password' , to: 'usuarios#password_save'      


        get :grupos 
        post :grupos, to: :grupo_catalago
        post :grupo_add
        post :grupo_del 

      end 
  end

  namespace :sigesp do

    resources :solicituds do 
      post :anular
      get  :compra ,to:  :editarcompra
      patch :compra ,to: :guardarcompra
      get  :presupuesto ,to: :editarpresupuesto
      patch  :presupuesto, to: :guardarpresupuesto
      get :traspasopresupuestario, to: :traspasopresupuestario
      get :disponibilidadpresupuestaria, to: :disponibilidadpresupuestaria
      post :reversarcompra
      post :reversarpresupuesto
    end 

    resources :solicitudsalmacens do |link|
      post :anular
      post :agregar_articulo, on: :collection
    end 

    get :articulos, to: 'articulos#articulos' , as: :articulos
    get :articulo_detalle, to: 'articulos#articulo_detalle' , as: :articulo_detalle

    get :articulos_almacen, to: 'articulos#almacen' , as: :articulos_almacen
    get "articulos/almacen/",  to: 'articulos#show' 

    get :servicios_solictud, to:'servicio_solicitud#index', as: :servicios_solictud
    get "servicios_solictud/detalle", to: 'servicio_solicitud#show', as: :servicios_solictud_detalle 


    ###### REGION SEDE SERVICIO ###############################################
    get :regiones, to: 'sede_servicio#regiones'
    get :servicios, to: 'sede_servicio#servicios', as: :servicios
    get :sedes, to: 'sede_servicio#sedes', as: :sedes

    ######## FUENTE FINANCIAMIENTO UNIDAD ADMINISTRATIVA ###############333 
    get :unidadesAdministrativas, to: "unidadadministrativa#unidadesAdministrativas"
  end


  root 'welcome#index'


end
