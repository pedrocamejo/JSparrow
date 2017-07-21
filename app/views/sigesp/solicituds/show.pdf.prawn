prawn_document(:page_layout => :landscape,:force_download=>false) do |pdf|
  letra_sm = 10
  pdf.define_grid(:columns => 12, :rows => 30, :gutter => 0)
  #pdf.grid.show_all

  pdf.repeat :all do
    pdf.grid([0,0], [3,3]).bounding_box do
      image = "#{Rails.root}/app/assets/images/pedro-camejo.png"
      pdf.image image, :at => [10,70] , :height => 70, :width => 120
      pdf.bounding_box([38,65], :width => 200, :height => 70) do  
        pdf.text  "<b>CVA CIA MECANIZADO AGRICOLA Y <b>",:inline_format => true, :size => letra_sm-1 ,align: :right #, :at => [118,pdf.cursor-10]
        pdf.text  "<b>TRANSPORTE PEDRO CAMEJO S.A.<b>",:inline_format => true, :size => letra_sm-1 ,align: :right #,:at => [118,pdf.cursor-20]
        pdf.text  "<b>RIF G-200079100<b>",:inline_format => true, :size => letra_sm-1 ,align: :right  #,:at => [190,pdf.cursor-30]
      end 
      pdf.stroke_bounds
    end 

    pdf.grid([0,4], [3,8]).bounding_box do
      pdf.text "REQUISICION" , :size => 18, :align=> :center , :valign => :center
      pdf.stroke_bounds
    end

    pdf.grid([0,9], [3,11]).bounding_box do
      texto = "<b>Nro: </b> #{@solicitud.numsol}\n<b>Fecha : </b> #{@solicitud.fecregsol}"
      pdf.indent 20, 5 do
        pdf.text texto, valign: :center, align: :right, size: letra_sm, inline_format: true , :valign => :center
      end
      pdf.stroke_bounds
    end
  end 

  pdf.grid([4,0], [6,8]).bounding_box do
    pdf.indent 10, 5 do  
      texto = "<b>CONCEPTO :</b>#{ truncate(@solicitud.consol,length: 650)}"
      pdf.text_box texto, :size => letra_sm-2,:inline_format => true, :align  => :justify  , :valign => :center
    end 
    pdf.stroke_bounds
  end

  pdf.grid([4,9], [4,11]).bounding_box do
    pdf.indent 20, 5 do  
      texto = "<b>TIPO REQUISICION :</b> #{tipoSolicitud(@solicitud.tipoSolicitud.dentipsol)}"
      pdf.text_box texto , :size => letra_sm-2,:inline_format => true, align: :justify ,:leading => 1.5 , :valign => :center
    end 
    pdf.stroke_bounds
  end

  pdf.grid([5,9], [6,11]).bounding_box do
    pdf.indent 20, 5 do  
      texto = """<b>REGION :</b> #{@solicitud.region.str_descripcion}
       <b>SESE :</b> #{@solicitud.sede.str_descripcion}
      <b>SERVICIO :</b> #{@solicitud.servicio.str_descripcion}"""
      pdf.text texto, :size => letra_sm-2,:inline_format => true  , :valign => :center 
    end 
    pdf.stroke_bounds
  end


  pdf.grid([7,0], [7,5]).bounding_box do
    pdf.indent 20, 5 do  
      texto = "<b>UNIDAD SOLICITANTE :</b> #{@solicitud.unidad.denuac}"
      pdf.text texto, :size => letra_sm-1,:inline_format => true, :align  => :justify ,:leading => 1.5 , :valign => :center
    end 
    pdf.stroke_bounds
  end 

  pdf.grid([7,6], [7,11]).bounding_box do
    pdf.indent 20, 5 do  
    texto = "<b>UNIDAD EJECUTORA :</b> #{@solicitud.unidadAdministrativa.denuniadm}"
      pdf.text texto, :size => letra_sm-1,:inline_format => true, :align  => :justify ,:leading => 1.5 , :valign => :center
    end 
    pdf.stroke_bounds
  end 

  

  titulo = ["ITEM","CANTIDAD SOLICITADA","UND. MEDIDA ","DESCRIPCION","PARTIDA PRESUPUESTARIA"]
  tabla = []
  tabla << titulo 
  @solicitud.articulos.includes(:articulo).references(:articulo).each_with_index do |articulo,index| 
    arr = []
    arr <<  index.to_s 
    arr <<  articulo.canart 
    arr <<  articulo.unidad 
    arr <<  articulo.articulo.denart  
    arr <<  articulo.spg_cuenta
    tabla << arr  
  end

  @solicitud.servicios.includes(:servicio).references(:servicio).each_with_index do |servicio,index| 
    arr = []
    arr <<  index.to_s 
    arr <<  servicio.canser 
    arr <<  "N/D" 
    arr <<  servicio.servicio.denser  
    arr <<  servicio.spg_cuenta
    tabla << arr  
  end

  pdf.grid([8,0], [24,11]).bounding_box do
    pdf.text "\n ESPECIFICACIONES" ,align: :center, size: 8
    pdf.table tabla, 
      header: true,
      width: 720,
      column_widths:  [40,60,80,460,80],
      cell_style: { 
          size: letra_sm-3,
          padding: 2,
          valign: :top,
          align: :justify
        },
      position: :left 
  end

  posicion = pdf.cursor()  

  pdf.grid([23,0], [23,2]).bounding_box do
    pdf.indent 20, 5 do  
        pdf.text "REALIZADO POR ",size: letra_sm-2 , align: :center, valign: :center
    end 
    pdf.stroke_bounds
  end 

  pdf.grid([23,3], [23,5]).bounding_box do
    pdf.indent 20, 5 do  
      pdf.text "AUTORIZADO POR RESPONSABLE DE LA UNIDAD O GERENCIA ",size:letra_sm-2 , align: :center, valign: :center 
    end 
    pdf.stroke_bounds
  end 
  
  pdf.grid([23,6], [23,8]).bounding_box do
    pdf.indent 20, 5 do  
      pdf.text "AUTORIZADO POR PRESIDENCIA/DIRECCION GENERAL ",size:letra_sm-2 ,align: :center , valign: :center
    end 
    pdf.stroke_bounds
  end 

  
  pdf.grid([23,9], [23,11]).bounding_box do
    pdf.bounding_box([2,18], :width => 180) do 
      pdf.text "POR DIRECCION DE PLANIFICACION Y PRESUPUESTO ",size:letra_sm-2 , align: :center 
    end 
      pdf.stroke_bounds
  end 

  nombre = @solicitud.usuario.usuario unless @solicitud.usuario.nil?

  pdf.grid([24,0], [25,0]).bounding_box do
    pdf.text "#{nombre}",size:letra_sm-5 , align: :center, valign: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,1], [25,2]).bounding_box do
    pdf.text "\nFIRMA",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,3], [25,3]).bounding_box do
    pdf.text "\nNOMBRES Y APELLIDOS ",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,4], [25,5]).bounding_box do
    pdf.text "\nFIRMA",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,6], [25,6]).bounding_box do
    pdf.text "\nNOMBRES Y APELLIDOS ",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,7], [25,8]).bounding_box do
    pdf.text "\nFIRMA",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 


  pdf.grid([24,9], [25,9]).bounding_box do
    pdf.text "\nNOMBRES Y APELLIDOS ",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([24,9], [25,11]).bounding_box do
    pdf.text "\nFIRMA",size:letra_sm-4 , align: :center
    pdf.stroke_bounds
  end 

  pdf.grid([26,0], [26,11]).bounding_box do
    pdf.text "PARA USO DE COMPRAS",size:letra_sm-3 , align: :center, valign: :center
    pdf.stroke_bounds
  end 

  pdf.grid([27,0], [27,3]).bounding_box do
    pdf.text "REALIZADO POR ",size:letra_sm-3 , align: :center, valign: :center
    pdf.stroke_bounds
  end 
  
  pdf.grid([27,4], [27,7]).bounding_box do
    pdf.text "AUTORIZADO POR RESPONSABLE DE LA UNIDAD O GERENCIA ",size:letra_sm-3 , align: :center, valign: :center 
    pdf.stroke_bounds
  end 
  
  pdf.grid([27,8], [27,11]).bounding_box do
    pdf.text "AUTORIZADO POR PRESIDENCIA/DIRECCION GENERAL ",size:letra_sm-3 , align: :center , valign: :center
    pdf.stroke_bounds
  end 

  pdf.grid([28,0], [30,3]).bounding_box do
    cell_1 = pdf.make_cell(content: "NOMBRE :\n CI : \nFIRMA : \n",width: 120,height: 54)
    cell_2 = pdf.make_cell(content: "FECHA:  \n \n SELLO: ",width: 120)

    pdf.table [
      [cell_1,cell_2]
      ],
      cell_style: { 
        size: letra_sm-3,
        padding: 2,
        valign: :top,
        align: :justify
      }
    pdf.stroke_bounds
  end 



  pdf.grid([28,4], [30,7]).bounding_box do
    cell_1 = pdf.make_cell(content: "NOMBRE :\n CI : \nFIRMA : \n",width: 120,height: 54)
    cell_2 = pdf.make_cell(content: "FECHA:  \n \n SELLO: ",width: 120)

    pdf.table [
      [cell_1,cell_2]
      ],
      cell_style: { 
        size: letra_sm-3,
        padding: 2,
        valign: :top,
        align: :justify
      }
    pdf.stroke_bounds
  end 


  pdf.grid([28,8], [30,11]).bounding_box do
    cell_1 = pdf.make_cell(content: "NOMBRE :\n CI : \nFIRMA : \n",width: 120,height: 54)
    cell_2 = pdf.make_cell(content: "FECHA:  \n \n SELLO: ",width: 120)

    pdf.table [
      [cell_1,cell_2]
      ],
      cell_style: { 
        size: letra_sm-3,
        padding: 2,
        valign: :top,
        align: :justify
      }
    pdf.stroke_bounds
  end 



  pdf.page_count().times do |i|
    pdf.go_to_page i 
      pdf.number_pages "<page> de <total> .",
        align: :right ,size: letra_sm-1, valign: :bottom,at: [pdf.bounds.width-170,20]
  end 

end


