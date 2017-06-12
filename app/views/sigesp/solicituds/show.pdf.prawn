prawn_document(:page_layout => :landscape,:force_download=>true) do |pdf|
 	letra_sm = 10

	pdf.repeat :all do
		pdf.bounding_box([0,540], :width => 260, :height => 75) do
		    pdf.stroke_bounds
			image = "#{Rails.root}/app/assets/images/pedro-camejo.png"
			pdf.image image, :at => [10,70] , :height => 70, :width => 120
			pdf.bounding_box([55,70], :width => 200, :height => 70) do  
 				pdf.text  "<b>CVA CIA MECANIZADO AGRICOLA Y <b>",:inline_format => true, :size => letra_sm-1 ,:align => :right #, :at => [118,pdf.cursor-10]
				pdf.text  "<b>TRANSPORTE PEDRO CAMEJO S.A.<b>",:inline_format => true, :size => letra_sm-1 ,:align => :right #,:at => [118,pdf.cursor-20]
				pdf.text  "<b>RIF G-200079100<b>",:inline_format => true, :size => letra_sm-1 ,:align => :right  #,:at => [190,pdf.cursor-30]
			end 
	  	end


		pdf.bounding_box([260,540], :width => 220, :height => 75) do
		    pdf.stroke_bounds
			pdf.text "REQUISICION" , :size => 18, :align=> :center , :valign => :center
	  	end

		pdf.bounding_box([480,540], :width => 240, :height => 75) do
	    	pdf.stroke_bounds
			pdf.bounding_box([30,70], :width => 200, :height => 70) do  
		    	texto = "<b>Nro: </b> #{@solicitud.numsol}\n<b>Fecha : </b> #{@solicitud.fecregsol}"
		    	pdf.text texto, :align => :right, :size => letra_sm, :inline_format => true
			end 
	  	end
 	end 

 	posicion = pdf.cursor
	pdf.bounding_box([0,posicion], :width => 520, :height => 60) do
		pdf.bounding_box([2,55], :width => 515, :height => 58) do  
			texto = "<b>CONCEPTO :</b>#{ truncate(@solicitud.consol,length: 650)}"
	    	pdf.text_box texto, :size => letra_sm-2,:inline_format => true, :align	=> :justify 
		end 
		pdf.stroke_bounds
  	end

	pdf.bounding_box([520,posicion], :width => 200,:height =>20) do
    	pdf.stroke_bounds
		pdf.bounding_box([10,15], :width => 200, :height => 20) do  
			texto = "<b>TIPO REQUISICION :</b> #{tipoSolicitud(@solicitud.tipoSolicitud.dentipsol)}"
	    	pdf.text_box texto , :size => letra_sm-2,:inline_format => true, :align	=> :justify ,:leading => 1.5
		end 
  	end

	pdf.bounding_box([520,posicion-20], :width => 200,:height =>40) do
    	pdf.stroke_bounds
		pdf.bounding_box([5,35], :width => 200, :height => 40) do  
			texto = "<b>REGION :</b> #{@solicitud.region.str_descripcion}"
		    pdf.text texto, :size => letra_sm-2,:inline_format => true  
			texto = "<b>SESE :</b> #{@solicitud.sede.str_descripcion}"
		    pdf.text texto, :size => letra_sm-2,:inline_format => true  
			texto = "<b>SERVICIO :</b> #{@solicitud.servicio.str_descripcion}"
		    pdf.text texto, :size => letra_sm-2,:inline_format => true  
		end 
  	end

  	posicion = pdf.cursor 
 
	pdf.bounding_box([0,posicion], :width => 360 ,:height =>15) do 
		pdf.bounding_box([2,12], :width => 360  ) do  
			texto = "<b>UNIDAD SOLICITANTE :</b> #{@solicitud.unidad.denuac}"
		    pdf.text texto, :size => letra_sm-1,:inline_format => true, :align	=> :justify ,:leading => 1.5
		end 
    	pdf.stroke_bounds
	end 

	pdf.bounding_box([360,posicion], :width => 360 ,:height =>15) do 
		pdf.bounding_box([2,12], :width => 360 ) do  
			texto = "<b>UNIDAD EJECUTORA :</b> #{@solicitud.unidadAdministrativa.denuniadm}"
		    pdf.text texto, :size => letra_sm-1,:inline_format => true, :align	=> :justify ,:leading => 1.5
		end 
	   	pdf.stroke_bounds
	end 


	pdf.text " \n ESPECIFICACIONES" ,:align => :center
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


	pdf.bounding_box([pdf.bounds.left,pdf.cursor], :width => pdf.bounds.width) do
	    # Restore the old y-position for the first page
		pdf.table tabla, :header => true , :width => 720  , :column_widths	=> [40,60,80,460,80],
		:cell_style => {size: letra_sm-3} , :position => :left 
	end

	posicion = pdf.cursor() - 20
	pdf.bounding_box([0,posicion], :width => 180, :height => 20 ) do 
		pdf.bounding_box([2,15], :width => 180) do 
			pdf.text "REALIZADO POR ",size:letra_sm-2 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	
	pdf.bounding_box([180,posicion], :width => 180, :height => 20 ) do 
		pdf.bounding_box([2,18], :width => 180) do 
		  pdf.text "AUTORIZADO POR RESPONSABLE DE LA UNIDAD O GERENCIA ",size:letra_sm-2 , :align => :center 
		end 
    	pdf.stroke_bounds
	end 
	
	pdf.bounding_box([360,posicion], :width => 180, :height => 20 ) do 
 		pdf.bounding_box([2,18], :width => 180) do 
			pdf.text "AUTORIZADO POR PRESIDENCIA/DIRECCION GENERAL ",size:letra_sm-2 , :align => :center 
		end 
    	pdf.stroke_bounds
	end 
	
	pdf.bounding_box([540,posicion], :width => 180, :height => 20 ) do 
		pdf.bounding_box([2,18], :width => 180) do 
			pdf.text "POR DIRECCION DE PLANIFICACION Y PRESUPUESTO ",size:letra_sm-2 , :align => :center 
		end 
    	pdf.stroke_bounds
	end 
	posicion = pdf.cursor()
	nombre = @solicitud.usuario.usuario unless @solicitud.usuario.nil?
	pdf.bounding_box([0,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "NOMBRES Y APELLIDOS \n #{nombre}",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([90,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "FIRMA",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 

	pdf.bounding_box([180,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "NOMBRES Y APELLIDOS ",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([270,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "FIRMA",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 

	pdf.bounding_box([360,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "NOMBRES Y APELLIDOS ",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([450,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "FIRMA",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 


	pdf.bounding_box([540,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "NOMBRES Y APELLIDOS ",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([630,posicion], :width => 90, :height => 40) do 
		pdf.bounding_box([2,35], :width => 90) do 
			pdf.text "FIRMA",size:letra_sm-4 , :align => :center
		end 
      pdf.stroke_bounds
	end 
 
    if (pdf.cursor() - 100) < 0 
	  pdf.start_new_page 
	  pdf.move_down 80
    end

	posicion =  pdf.cursor()
	pdf.bounding_box([0,posicion], :width => 720, :height => 20) do 
		pdf.bounding_box([2,15], :width => 720) do 
			pdf.text "PARA USO DE COMPRAS",size:letra_sm-2 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	posicion = pdf.cursor()  
	pdf.bounding_box([0,posicion], :width => 240, :height => 20 ) do 
		pdf.bounding_box([2,15], :width => 240) do 
			pdf.text "REALIZADO POR ",size:letra_sm-2 , :align => :center
		end 
      pdf.stroke_bounds
	end 
	
	pdf.bounding_box([240,posicion], :width => 240, :height => 20 ) do 
		pdf.bounding_box([2,18], :width => 240) do 
		  pdf.text "AUTORIZADO POR RESPONSABLE DE LA UNIDAD O GERENCIA ",size:letra_sm-2 , :align => :center 
		end 
    	pdf.stroke_bounds
	end 
	
	pdf.bounding_box([480,posicion], :width => 240, :height => 20 ) do 
 		pdf.bounding_box([2,18], :width => 240) do 
			pdf.text "AUTORIZADO POR PRESIDENCIA/DIRECCION GENERAL ",size:letra_sm-2 , :align => :center 
		end 
    	pdf.stroke_bounds
	end 
	posicion = pdf.cursor()  
	pdf.bounding_box([0,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="NOMBRE : \nCI : \nFIRMA :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([120,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="FECHA : \n\n\nSELLO :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([240,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="NOMBRE : \nCI : \nFIRMA :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([360,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="FECHA : \n\n\nSELLO :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([480,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="NOMBRE : \nCI : \nFIRMA :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 
	pdf.bounding_box([600,posicion], :width => 120, :height => 60) do 
		pdf.bounding_box([3,55], :width => 120) do 
			texto ="FECHA : \n\n\nSELLO :"
			pdf.text texto,size:6 
		end 
      pdf.stroke_bounds
	end 

	pdf.page_count().times do |i|
		pdf.go_to_page i 
	    pdf.number_pages "<page> de <total> .", :align => :right ,:size => letra_sm-1, :valign => :bottom , :at => [pdf.bounds.width-170,30]
	end 

end


