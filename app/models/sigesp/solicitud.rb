class Sigesp::Solicitud < ActiveRecord::Base 

	self.primary_key = 'numsol'	
  self.table_name = 'public.sep_solicitud'

	has_many :gastos, 
    class_name: "Sigesp::CuentaGasto", 
    foreign_key:"numsol",
    inverse_of: :solicitud, 
    dependent: :delete_all

  has_many :articulos, 
    class_name: "Sigesp::DtArticulo",
    foreign_key: "numsol",
    autosave: true,
    validate: true, 
    dependent: :destroy  

  has_many :articulos_cargos,
    class_name: "Sigesp::DtCargo",
    foreign_key: [:codemp,:numsol,:codart],
    through: :articulos,
    source: :cargo

  has_many :servicios,
    class_name: "Sigesp::DtServicio",
    foreign_key: "numsol", 
    autosave: true,
    validate: true,
    dependent: :destroy

  has_many :servicios_cargos, 
    class_name: "Sigesp::DtsCargo", 
    foreign_key: [:codemp,:numsol,:codser],
    through: :servicios,
    source: :cargo

  has_many :cargos,
    class_name: "Sigesp::SolicitudCargo",
    foreign_key: "numsol", 
    autosave: true

  has_one :usuario,
    class_name: "Sigesp::SolicitudUser", 
    foreign_key:"numsol", 
    autosave: true

  has_one :tipo, 
    class_name: "Sigesp::SolicitudTipo", 
    foreign_key:"numsol", 
    autosave: true



  belongs_to :unidad, class_name: "Public::SpgMinisterioUa"  , foreign_key: "undadm"
  belongs_to :unidadAdministrativa, foreign_key: "coduniadm", class_name: "Sigesp::UnidadAdministrativa"
  belongs_to :tipoSolicitud, foreign_key: "codtipsol", class_name: "Sigesp::TipoSolicitud"
  belongs_to :region , foreign_key: "cod_region", class_name: "Sigesp::Region"
  belongs_to :sede , foreign_key: "cod_sede", class_name: "Sigesp::Sede"
  belongs_to :servicio, foreign_key:"cod_servicio", class_name: "Sigesp::Servicio"
  belongs_to :fuenteFinanciamiento,foreign_key:"codfuefin", class_name: "Sigesp::FuenteFinanciamiento"


 
  validates :cod_region,presence: {message: 'Seleccione '}
  validates :cod_sede,presence: {message: 'Seleccione '}
  validates :cod_servicio,presence: {message: 'Seleccione '}
  validates :consol,presence: {message: 'Ingrese Concepto  '}# , length: {maximum: 1000, too_long:"%{count} caracteres es el maximo  "}
  
  validates :coduniadm,presence: {message: 'Seleccione Unidad Administrativa  '}
  validates :codfuefin,presence: {message: 'Seleccione Fuente Financiamiento  '}

  validates_presence_of :articulos, if: :solicitud_articulo?, message: "Ingese al menos 1 articulo " 
  validates_presence_of :servicios, if: :solicitud_servicio?, message:  "Ingese al menos 1 servicio "
  	
  accepts_nested_attributes_for :articulos 
  accepts_nested_attributes_for :servicios 
 
  def solicitud_servicio?
    self.codtipsol == "02"
  end 
  
  def solicitud_articulo?
    self.codtipsol == "01"
  end 

  def articulos_attributes=(detalles)
    _monto  = 0.0 
    _monbasinm  = 0.0  
    _montotcar = 0.0 
    
    self.articulos.delete_all unless self.numsol.nil?
    detalles.each do |detalle|
      detalle[:monpre] = 0 unless  detalle.include?(:monpre)
      d = Sigesp::DtArticulo.new(
        detalle.merge(
            solicitud: self,
            codemp: "0001",
            unidad: "D",
            monart: 0,
            codestpro1: "00000000000000000000",
            codestpro2: "000000",
            codestpro3: "000",
            codestpro4: "00",
            codestpro5: "00"
          )
        ) 
      d.monart = d.canart * d.monpre 
      d.spg_cuenta = d.articulo.spg_cuenta
      self.articulos << d  
      if self.tipo.bol_compra
        cargo = Sigesp::Cargo.iva7 if(self.porcar ==  7 )
        cargo = Sigesp::Cargo.iva8 if(self.porcar ==  8 )
        cargo = d.articulo.cargo_activo(self.porcar) if self.porcar == 12 

        if cargo.nil?
          errors.add(:articulos, "Error el Articulo  #{d.articulo.denart}  no tiene un cargo Definido") 
        else 
          dtcargo = Sigesp::DtCargo.new(
            solicitud:  self,
            codemp:  "0001" ,
            codart: d.codart,
            cargo:  cargo,
            monbasimp:  (d.canart * d.monpre),
            monimp:  (d.canart * d.monpre) * ( cargo.porcar/100),
            formula:  cargo.formula,
            cod_servicio:  self.cod_servicio,
            cod_sede:  self.cod_sede,
            cod_region:  self.cod_region,
            str_codregionsedeservicio: self.str_codregionsedeservicio
          )
          dtcargo.monto =  dtcargo.monbasimp + dtcargo.monimp 
          #self.articulos_cargos << dtcargo  
          d.cargo = dtcargo
          _monto  += d.monart
          _montotcar += dtcargo.monimp
        end 
      end 
    end
    _monbasinm  = _monto + _montotcar
    self.monto    = _monto
    self.monbasinm = _monbasinm
    self.montotcar = _montotcar
  end

  def servicios_attributes=(detalles)
    _monto  = 0.0 
    _monbasinm  = 0.0 
    _montotcar = 0.0 
    self.servicios.delete_all unless self.numsol.nil?
    detalles.each do |detalle|
      detalle[:monpre] = 0 unless  detalle.include?(:monpre)
      d = Sigesp::DtServicio.new(
        detalle.merge(
          solicitud: self,
          codemp: "0001",
          orden: 0,
          monser: 0,
          codestpro1: "00000000000000000000",
          codestpro2: "000000",
          codestpro3: "000",
          codestpro4: "00",
          codestpro5: "00"
        )
      )

      d.monser = d.canser * d.monpre 
      d.spg_cuenta = d.servicio.spg_cuenta
      cargo = d.servicio.cargo_activo()
      if cargo.nil?
        errors.add(:servicios, "Error el Servicio #{d.servicio.denser} no tiene un cargo Definido") 
      else 
        dtcargo = Sigesp::DtsCargo.new(
          solicitud:  self,
          codemp:  "0001" ,
          codser: d.codser,
          cargo:  cargo,
          monbasimp:  (d.canser * d.monpre),
          monimp:  (d.canser * d.monpre) * ( cargo.porcar/100),
          formula:  cargo.formula
        )
        dtcargo.monto =  dtcargo.monbasimp + dtcargo.monimp 
        d.cargo = dtcargo
        _monto  += d.monser
        _montotcar += dtcargo.monimp
      end 
      self.servicios << d  
    end
    _monbasinm  = _monto + _montotcar
    self.monto    = _monto
    self.monbasinm = _monbasinm
    self.montotcar = _montotcar
  end


  def agregar_articulo(articulo)
    self.articulos.each do |art|
      return if art.codart == articulo.codart 
    end 
    self.articulos << articulo
  end 

  def id 
		sync_with_transaction_state
		read_attribute(self.class.primary_key)
	end


  def self.search_compra(page = 1,search=nil,sort=nil,unidad=nil)
    search ||= "" 
    sort ||= "" 
    sort = "public.sep_solicitud.numsol" if sort == "numero solicitud"
    sort = "consol" if sort == "concepto"
    sort = "fecregsol" if sort == "fecha"
    sort = "estsol" if sort == "estado"

    join =" INNER JOIN sigesp_espc.sep_solicitud_tipo ON sigesp_espc.sep_solicitud_tipo.numsol = public.sep_solicitud.numsol" 
    if search.empty? 
      if unidad.nil?
        where = "sigesp_espc.sep_solicitud_tipo.bol_compra = true"
        joins(join).paginate(page:page).where(where).order(numsol: :desc) #rescue paginate(page: 1) 
      else
        where = "sigesp_espc.sep_solicitud_tipo.bol_compra = true and undadm = :undadm "
        joins(join).paginate(page:page).where(where,{undadm:unidad['coduac']}).order(numsol: :desc) #rescue paginate(page: 1) 
      end 
    else
      if unidad.nil?
        where = "sigesp_espc.sep_solicitud_tipo.bol_compra = true and #{sort} like :search "
        joins(join).paginate(page:page).where(where,{search:"%#{search}%"}).order(sort)
      else
        where = "sigesp_espc.sep_solicitud_tipo.bol_compra = true  and undadm = :unidad and #{sort} like :search"
        joins(join).paginate(page:page).where(where,{unidad:unidad['coduac'],search:"%#{search}%"}).order(sort)
      end 
    end 
  end 
 
  def self.search_almacen(page = 1 , search , sort,unidad )
    search ||= "" 
    sort ||= "" 
    sort = "public.sep_solicitud.numsol" if sort == "numero solicitud"
    sort = "consol" if sort == "concepto"
    sort = "fecregsol" if sort == "fecha"
    sort = "estsol" if sort == "estado"
    join =" INNER JOIN sigesp_espc.sep_solicitud_tipo ON sigesp_espc.sep_solicitud_tipo.numsol = public.sep_solicitud.numsol" 
    if search.empty? 
      joins(join).paginate(page:page).where("sigesp_espc.sep_solicitud_tipo.bol_compra = false and undadm = ?",unidad['coduac']).order(numsol: :desc) #rescue paginate(page: 1) 
    else
        where = "sigesp_espc.sep_solicitud_tipo.bol_compra = false and undadm = :unidad and #{sort} like :search"
        joins(join).paginate(page:page).where(where,{unidad:unidad['coduac'],search:"%#{search}%"}).order(sort)
    end 
  end 


  def self.crear_solicitud_plantilla plantilla_id 
    plantilla = Plantilla.find(plantilla_id)
    solicitud = Sigesp::Solicitud.new 
    if(plantilla.tipo == 1)
      solicitud.codtipsol = "01"
      plantilla.articulos.each do |art|
        solicitud.articulos << Sigesp::DtArticulo.new(
          solicitud: solicitud,
          articulo: art,
          canart: 1,
          unidad: art.unidad.denunimed
       )
      end 
    else
      solicitud.codtipsol = "02"
      plantilla.servicios.each do |ser|
        solicitud.servicios << Sigesp::DtServicio.new(
          solicitud: solicitud,
          servicio: ser ,
          canser: 1 
       )
      end 
    end 
    solicitud 
  end 

  def solicitud_tipo?
    solicitudTipos[0].bol_compra?
  end

  def almacen_articulos
    if articulos.size == 0 
      nil
    else
      articulos[0].almacen 
    end 
  end 

  def destino_solicitud
    "#{region.str_descripcion} #{sede.str_descripcion} #{servicio.str_descripcion}"
  end 
 

  def actualizar params 
    transaction do 
      update! params
      Sigesp::DtArticulo.actualizar_costos self.articulos
    end 
  end 

  def guardar(unidad=nil,usuario=nil)
    unless unidad.nil?
      self.undadm = unidad['coduac']
      control = Sigesp::CtrlRequisicion.control_compra(unidad)
      self.numsol = control.codigo_solicitud()
      self.tipo.numsol = numsol 
      self.usuario = Sigesp::SolicitudUser.solicitudnueva(self.numsol,usuario) unless usuario.nil?
    end 
    transaction do 
      #if valid?
        save!()
        control.save!() unless control.nil?
      #else
      #  raise ActiveRecord::Rollback
      # end 
    end 
    #borrar_articulos_cargos
    #borrar_articulos
    #borrar_servicios_cargos
    #borrar_servicios
  end 


  def self.crear_solicitud_compra(params)
    inicializar = {
        codemp: "0001",
        tipo_destino: '-',
        cod_pro:   '----------',
        ced_bene:  '----------',
        codfuefin: "--",
        coduniadm: "----------",
        estsol: 'E' ,
        #montotcar: 0 ,
        estapro: 0 ,
        fecregsol: Time.now,
        tipo: Sigesp::SolicitudTipo.solicitud_compra()
    }
    arr = inicializar.merge(params)
    puts arr.to_s
    solicitud = Sigesp::Solicitud.new(arr ) 
    #if solicitud.codtipsol == "01" 
    # Sigesp::DtArticulo._articulosCompra(solicitud,params_detalle)
    #else
    #  Sigesp::DtServicio._serviciosCompra(solicitud,params_detalle) 
    #end 
    solicitud
  end


  def self.crear_solicitudes_almacen(parametros) 
    articulos = Sigesp::DtArticulo.articulos_almacen(parametros[:articulos_attributes])
    almacenes = Sigesp::Almacen.all
    solicitudes = []
    almacenes.each do |almacen|
      _articulos = []
      articulos.each do |articulo|
        if articulo.almacen.codalm == almacen.codalm
          _articulos << articulo 
        end 
      end   
      if _articulos.size != 0 
        solicitud = Sigesp::Solicitud.new(
          codemp: "0001",
          cod_region:  parametros["cod_region"],
          cod_sede: parametros["cod_sede"],
          cod_servicio: parametros["cod_servicio"],
          consol: parametros["consol"],
          tipo_destino: '-',
          cod_pro: '----------',
          ced_bene:  '----------',
          codfuefin: "--",  # ninguna Fuente de Financiamiento
          coduniadm: "----------", # ninguna Unidad Administrativa 
          estsol: 'E' ,
          montotcar: 0, 
          estapro: 0 ,
          fecregsol: Time.now,
          codtipsol: "01",
          tipo: Sigesp::SolicitudTipo.solicitud_almacen()
        )
        solicitud.articulos += _articulos 
        solicitud.articulos.each {|a| a.solicitud  = solicitud }
        solicitudes << solicitud
      end 
    end 
    solicitudes 
  end 

  def actualizar_fuentefinanciamiento(sigesp_solicitud_params_presupuesto,presupuesto)
    transaction do 
      update(sigesp_solicitud_params_presupuesto)
      # actualizar articulos o servicios
      articulos.update_all(codestpro1: presupuesto[:codestpro1],codestpro2: presupuesto[:codestpro2],
        codestpro3: presupuesto[:codestpro3],codestpro4: presupuesto[:codestpro4],codestpro5: presupuesto[:codestpro5],
        estincite: "NI")

      servicios.update_all(codestpro1: presupuesto[:codestpro1],codestpro2: presupuesto[:codestpro2],
        codestpro3: presupuesto[:codestpro3],codestpro4: presupuesto[:codestpro4],codestpro5: presupuesto[:codestpro5],
         estincite: "NI")

      Sigesp::CuentaGasto.delete_all(numsol:self.numsol) 
      crear_cuentas_gastos
      cargos_solicitud(presupuesto)
    end 
  end 

  #por cuestiones de tiempo   pero hay que organizarlo 
  def cargos_solicitud(presupuesto)
    delete = "Delete FROM public.sep_solicitudcargos where numsol='#{self.numsol}';"  
    cargo = """ INSERT INTO public.sep_solicitudcargos (codemp, numsol, codcar, codestpro1, codestpro2, codestpro3, codestpro4, codestpro5, spg_cuenta, cod_pro, ced_bene, sc_cuenta, formula) 
          SELECT distinct '0001' as codemp,A.numsol,A.codcar,
            '#{presupuesto[:codestpro1]}' as codestpro1,'#{presupuesto[:codestpro2]}' as codestpro2,
            '#{presupuesto[:codestpro3]}' as codestpro3,'#{presupuesto[:codestpro4]}' as codestpro4,
            '#{presupuesto[:codestpro5]}' as codestpro5,trim(spg_cuenta),'----------' as cod_pro,'----------' as ced_bene, 
            '11212000spg_ep30001             ' as sc_cuenta, A.formula 
          FROM public.sep_dta_cargos A JOIN public.sigesp_cargos using (codemp, codcar) 
          WHERE  A.numsol = '#{self.numsol}' 
          UNION ALL
          SELECT distinct '0001' as codemp,A.numsol,A.codcar,
            '#{presupuesto[:codestpro1]}' as codestpro1,'#{presupuesto[:codestpro2]}' as codestpro2,
            '#{presupuesto[:codestpro3]}' as codestpro3,'#{presupuesto[:codestpro4]}' as codestpro4,
            '#{presupuesto[:codestpro5]}' as codestpro5, trim(spg_cuenta),'----------' as cod_pro,'----------' as ced_bene,
            '11212000spg_ep30001             ' as sc_cuenta, A.formula 
          FROM public.sep_dts_cargos A JOIN public.sigesp_cargos using (codemp, codcar)  
          WHERE  A.numsol = '#{self.numsol}'; """
    Sigesp::Solicitud.connection.execute(delete)
    Sigesp::Solicitud.connection.execute(cargo)
  end 

  def crear_cuentas_gastos 
    delete = " Delete FROM public.sep_cuentagasto where numsol ='#{self.numsol}'"

    servicios = """insert into public.sep_cuentagasto(codemp, numsol, codestpro1, codestpro2, codestpro3,
        codestpro4, codestpro5, spg_cuenta, codfuefin, monto, montoaux,
        cod_servicio,cod_sede,cod_region,str_codRegionSedeServicio )
      select A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4,
         A.codestpro5, trim(A.spg_cuenta), public.sep_solicitud.codfuefin, sum(monser) as monto, sum(monpreaux) as 
         montoaux ,A.cod_servicio,A.cod_sede,A.cod_region,A.str_codRegionSedeServicio
      from public.sep_dt_servicio as A inner join public.sep_solicitud using(codemp, numsol) 
      where A.numsol = '#{self.numsol}' and not A.spg_cuenta = 'null' 
      group by A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4,
      A.codestpro5,trim(A.spg_cuenta),A.cod_servicio,A.cod_sede,A.cod_region,A.str_codRegionSedeServicio,
      public.sep_solicitud.codfuefin;
      """

    articulos = """ insert into public.sep_cuentagasto(codemp, numsol, codestpro1, codestpro2, codestpro3,
        codestpro4, codestpro5, spg_cuenta, codfuefin, monto, montoaux ,
        cod_servicio,cod_sede,cod_region,str_codRegionSedeServicio ) 
      select A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4, 
        A.codestpro5, trim(A.spg_cuenta),public.sep_solicitud.codfuefin, sum(monart) as monto, sum(monpreaux) as 
        montoaux, A.cod_servicio,A.cod_sede, A.cod_region,A.str_codRegionSedeServicio 
      from public.sep_dt_articulos as A inner join public.sep_solicitud using(codemp, numsol) 
      where A.numsol = '#{self.numsol}' and not A.spg_cuenta = 'null'
      group by A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4,
      A.codestpro5,trim(A.spg_cuenta),A.cod_servicio,A.cod_sede,A.cod_region,A.str_codRegionSedeServicio,
      public.sep_solicitud.codfuefin;
      """
    Sigesp::Solicitud.connection.execute(delete)
    Sigesp::Solicitud.connection.execute(servicios)
    Sigesp::Solicitud.connection.execute(articulos)
  end 
  #spg_ep1_5 return a has map if there anything in articulos 
  
  def spg_ep1_5
    spg_1_5= {}
    if articulos.size >= 1 
      articulo = articulos.first
      spg_1_5[:codestpro1] = articulo.codestpro1 
      spg_1_5[:codestpro2] = articulo.codestpro2
      spg_1_5[:codestpro3] = articulo.codestpro3
      spg_1_5[:codestpro4] = articulo.codestpro4
      spg_1_5[:codestpro5] = articulo.codestpro5
    end 
    spg_1_5
  end 

#  def articulos_aux
#    @articulo_aux = [] if @articulo_aux.nil?
#    @articulo_aux 
#  end 

#  def articulos_cargo_aux
#    @articulo_aux_cargo = [] if @articulo_aux_cargo.nil?
#    @articulo_aux_cargo 
#  end 


#  def servicios_aux
#    @servicio_aux = [] if @servicio_aux.nil?
#    @servicio_aux 
#  end 

#  def servicios_cargos_aux
#    @servicio_cargo_aux = [] if @servicio_cargo_aux.nil?
#    @servicio_cargo_aux 
#  end 

  def emitida? 
    self.estsol == 'E'
  end 

  def registrada?
    self.estsol  == 'R'
  end 

  def contabilizada? 
    self.estsol  == 'C'
  end 

  def anulada?
    self.estsol  == 'A'
  end 

  def procesada?
    self.estsol  == 'P'
  end 

  def despachada?
    self.estsol == 'D' 
  end 

  def espera_aprobacion_admin?
    self.estsol  == 'I'
  end 

  def analisis?
    self.estsol  == 'O'
  end 

  def espera_aprobacion_pres?
     self.estsol  == 'V'
  end 

  def parcial?
    self.estsol  == 'L'
  end 
 

  self.per_page = 10 
end


#SELECT prefijo, valor FROM sigesp_espc.sigesp_ctrl_requisicion where coduac = '00035'

#INSERT INTO sep_solicitud 
#(codemp, numsol, codtipsol, coduniadm, codfuefin, fecregsol, estsol, consol, monto, 
#  monbasinm, montotcar, tipo_destino, cod_pro, ced_bene, undadm, estapro ,  cod_servicio ,
#  cod_sede ,cod_region ,str_codRegionSedeServicio ) VALUES
#('0001','OTI000000000015', '01', '0000000005', '14', '2015-05-21', 'E', 'EASDDASD',
#3500.0,3920.0,420.0,'-', '----------', '----------', '00035',0,'0001', '0003', '0002', '000200030001')

#INSERT INTO sigesp_espc.sep_solicitud_tipo (codemp, numsol, bol_compra,coddepalmacen) VALUES('0001','OTI000000000015',false,'00020')
#INSERT INTO sep_dt_articulos (codemp, numsol, codart, canart, unidad, monpre,  monart, orden,codestpro1, codestpro2, codestpro3, codestpro4, codestpro5, spg_cuenta, estincite, cod_servicio , cod_sede ,cod_region ,str_codRegionSedeServicio ) VALUES('0001','OTI000000000015', '451016030004322', 1.0, 'D', 3500.0, 3500.0, 0, '00000000000000000002', '000004', '014', '00', '00', '402100800','NI','0001', '0003', '0002', '000200030001')


#INSERT INTO sep_dta_cargos(codemp, numsol, codart, codcar, monbasimp, monimp, monto, 
# formula, cod_servicio , cod_sede ,cod_region ,str_codRegionSedeServicio ) 
#VALUES('0001','OTI000000000015', '451016030004322', '00515', 3500.0, 420.0,
# 0.0,'$LD_MONTO*0.12','0001', '0003', '0002', '000200030001')

#INSERT INTO sep_solicitudcargos (codemp, numsol, codcar, codestpro1, codestpro2, codestpro3, 
#codestpro4, codestpro5, spg_cuenta, cod_pro, ced_bene, sc_cuenta, formula)
# SELECT distinct '0001' as codemp, A.numsol, A.codcar, '00000000000000000002' as codestpro1, '000004' as codestpro2, '014' as codestpro3, '00' as codestpro4, '00' as codestpro5,  spg_cuenta, '----------' as cod_pro, '----------' as ced_bene, '11212000spg_ep30001             ' as sc_cuenta, A.formula   FROM sep_dta_cargos A JOIN sigesp_cargos using (codemp, codcar)  WHERE  A.numsol = 'OTI000000000015' UNION ALL SELECT distinct '0001' as codemp, A.numsol, A.codcar, '00000000000000000002' as codestpro1, '000004' as codestpro2, '014' as codestpro3, '00' as codestpro4, '00' as codestpro5,  spg_cuenta, '----------' as cod_pro, '----------' as ced_bene, '11212000spg_ep30001             ' as sc_cuenta, A.formula   FROM sep_dts_cargos A JOIN sigesp_cargos using (codemp, codcar)  WHERE  A.numsol = 'OTI000000000015'



#Delete FROM sep_cuentagasto where numsol ='OTI000000000015'

#Insert into sep_cuentagasto(codemp, numsol, codestpro1, codestpro2, codestpro3,  
#codestpro4, codestpro5, spg_cuenta, codfuefin, monto, montoaux,  
#cod_servicio,cod_sede,cod_region,str_codRegionSedeServicio )  

#select A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4,
# A.codestpro5,  A.spg_cuenta, sep_solicitud.codfuefin, sum(monser) as monto, 
#sum(monpreaux) as montoaux , A.cod_servicio,A.cod_sede,A.cod_region,
#A.str_codRegionSedeServicio  from sep_dt_servicio as A inner join sep_solicitud 
#using(codemp, numsol) where A.numsol = 'OTI000000000015' and not A.spg_cuenta = 'null'
#group by A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4, 
#A.codestpro5, A.spg_cuenta,A.cod_servicio,A.cod_sede,A.cod_region,A.str_codRegionSedeServicio,
#sep_solicitud.codfuefin;


# insert into sep_cuentagasto(codemp, numsol, codestpro1, codestpro2, codestpro3, 
#  codestpro4, codestpro5, spg_cuenta, codfuefin, monto, montoaux ,cod_servicio,cod_sede,
#  cod_region,str_codRegionSedeServicio )  
# select A.codemp, A.numsol, A.codestpro1,
#   A.codestpro2, A.codestpro3, A.codestpro4, A.codestpro5, A.spg_cuenta, 
#   sep_solicitud.codfuefin, sum(monart) as monto, sum(monpreaux) as montoaux, 
#   A.cod_servicio,A.cod_sede,  A.cod_region,A.str_codRegionSedeServicio  
#    from sep_dt_articulos as A inner join sep_solicitud using(codemp, numsol) 
#    where A.numsol = 'OTI000000000015' and not A.spg_cuenta = 'null'  group by
#    A.codemp, A.numsol, A.codestpro1, A.codestpro2, A.codestpro3, A.codestpro4, 
#    A.codestpro5,  A.spg_cuenta,A.cod_servicio,A.cod_sede,A.cod_region,
#    A.str_codRegionSedeServicio,sep_solicitud.codfuefin;

#INSERT INTO sigesp_espc.sep_solicitud_user (codemp, numsol, usuario) VALUES('0001', 'OTI000000000015', 'RHONAL CHIRINOS')

    