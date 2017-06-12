class Sigesp::DtArticulo < ActiveRecord::Base
    self.primary_keys = [:codemp, :numsol, :codart]
    self.table_name = 'public.sep_dt_articulos'

	belongs_to :solicitud,
        foreign_key: "numsol",
        class_name: "Sigesp::Solicitud"

	belongs_to :articulo,
        foreign_key: "codart",
        class_name: "Sigesp::Articulo"

    belongs_to :almacen,
        foreign_key: "codalm",
        class_name: "Sigesp::Almacen"

    has_one :cargo , class_name: "Sigesp::DtCargo",
    foreign_key: [:codemp,:numsol,:codart],
    autosave: true,
    dependent: :destroy 

    validates :solicitud,presence: {message: 'Seleccione '}
    validates :articulo,presence: {message: 'Seleccione '}
    validates :canart,presence: {message: 'Ingrese '}
    validates :canart, numericality: {greater_than:0,message: 'Ingrese cantidad '}

    validates_with ArticulosAlmacenValidator

    def self.actualizar_costos detalle_articulos
        detalle_articulos.each do |dt_articulo|
            dt_articulo.articulo.actualizar_ultimo_costo(dt_articulo.monpre)
        end  
    end  

    def self.articulos_almacen(articulos_params)  
        articulos = []
        unless  articulos_params.nil?
            articulos_params.each do |detalle|
                codart = detalle["codart"]
                codalm = detalle["codalm"]
                canart = detalle["canart"]
                articulo =  Sigesp::Articulo.find(codart)  
                articulo = Sigesp::DtArticulo.new(
                        codart: codart,
                        codalm: codalm,
                        canart: canart,
                        codemp: "0001",
                        unidad: 'D',
                        monart: 0,
                        monpre: 0,
                        codestpro1: "00000000000000000000",
                        codestpro2: "000000",
                        codestpro3: "000",
                        codestpro4: "00",
                        codestpro5: "00",
                        spg_cuenta: articulo.spg_cuenta
                )
                articulos << articulo 
            end
        end 
        articulos
    end 

    def id 
        sync_with_transaction_state
        read_attribute(self.class.primary_key)
    end

end 

