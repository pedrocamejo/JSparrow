prawn_document(:page_layout => :landscape,:force_download=>true) do |pdf|
 	letra_sm = 10

	pdf.repeat :all do
		pdf.bounding_box([0,540], :width => 260, :height => 75) do
		   # pdf.stroke_bounds
			image = "#{Rails.root}/app/assets/images/logocvalpc.png"
			pdf.image image, :at => [10,50]
			pdf.text "\nCVA CIA MECANIZADO AGRICOLA Y ", :size => letra_sm-2, :align=> :right ,:leading => 2 
			pdf.text "TRANSPORTE PEDRO CAMEJO S.A. ", :size => letra_sm-2, :align=> :right
			pdf.text "RIF G-200079100.", :size => letra_sm-2, :align=> :right 
	  	end

		pdf.bounding_box([260,540], :width => 200, :height => 75) do
		    #pdf.stroke_bounds
			pdf.text "SOLICITUD DE DISPONIBILIDAD \n PRESUPUESTARIA" , :size => 14, :align=> :center , :valign => :center
	  	end

		pdf.bounding_box([480,540], :width => 240, :height => 75) do
	    	#pdf.stroke_bounds
	    	texto = "\nNro: #{@solicitud.numsol} \n Fecha : #{@solicitud.fecregsol}"
	    	pdf.text_box texto, :align => :right, :size => letra_sm-1,
			  	 :valign => :top , :inline_format => true
	  	end
	 	pdf.stroke  do
			pdf.horizontal_rule
		end
 	end # todas las Paginas 

	pdf.bounding_box([0,pdf.cursor() - 10 ], :width => 720 ) do 
		texto = "<b>UNIDAD SOLICITANTE :</b> #{@solicitud.unidad.denuac} \t \t <b>UNIDAD EJECUTORA :</b> #{@solicitud.unidadAdministrativa.denuniadm}"
	    pdf.text texto, :size => letra_sm,:inline_format => true, :align	=> :justify ,:leading => 1.5
		texto = "<b>REGION SESE SERVICIO :</b> #{@solicitud.destino_solicitud}"
	    pdf.text texto, :size => letra_sm,:inline_format => true,:align	=> :justify ,:leading => 1.5 
		texto = "<b>CONCEPTO :</b> #{@solicitud.consol}"
	    pdf.text texto , :size => letra_sm,:inline_format => true, :align	=> :justify ,:leading => 1.5
	end 
	pdf.text " \n ESPECIFICACIONES" ,:align => :center
	titulo = ["DESCRIPCION","MONTO","N° CATEGORIA PRESUPUESTARIA","FUENTE FINANCIAMIENTO","CUENTA PRESUPUESTARIA"]

	tabla = []
	tabla << titulo 
	@solicitud.articulos.includes(:articulo).references(:articulo).each do |articulo| 
		arr = []
		arr <<  articulo.articulo.denart 
		arr <<  articulo.monart
	    arr <<  @solicitud.fuenteFinanciamiento.denfuefin
	    arr <<  "#{articulo.codestpro1}#{articulo.codestpro2}#{articulo.codestpro3}#{articulo.codestpro4}#{articulo.codestpro5}" 
	    arr <<  articulo.spg_cuenta
	    tabla << arr  
	end

	@solicitud.servicios.includes(:servicio).references(:servicio).each do |servicio| 
		arr = []
		arr <<  servicio.servicio.denser 
		arr <<  servicio.monser
	    arr <<  @solicitud.fuenteFinanciamiento.denfuefin
	    arr <<  "#{servicio.codestpro1}#{servicio.codestpro2}#{servicio.codestpro3}#{servicio.codestpro4}#{servicio.codestpro5}" 
	    arr <<  servicio.spg_cuenta
	    tabla << arr  
	end


	pdf.bounding_box([pdf.bounds.left,pdf.cursor], :width => pdf.bounds.width) do
	    # Restore the old y-position for the first page
		pdf.table tabla, :header => true , :width => 720  , :column_widths	=> [184,50,248,158,80],
		:cell_style => {size: letra_sm-3} , :position => :left 
	end
 

	pdf.bounding_box([0,pdf.cursor()-10], :width => 720) do 
		texto = "<b>MONTO  :</b> #{@solicitud.monto} "
	    pdf.text texto, :size => letra_sm-1,:inline_format => true, :align	=> :right ,:leading => 1.5
		texto = "<b>CARGO  :</b> #{@solicitud.montotcar}"
	    pdf.text texto, :size => letra_sm-1,:inline_format => true,:align	=> :right ,:leading => 1.5 
		texto = "<b>TOTAL :</b> #{@solicitud.monbasinm}"
	    pdf.text texto , :size => letra_sm-1,:inline_format => true, :align	=> :right ,:leading => 1.5
	end 
	posicion = pdf.cursor() -10
	pdf.bounding_box([0,posicion], :width => 200) do 
	  pdf.text "FUNCIONARIO SOLICITANTE:",size:letra_sm-1
	  pdf.text "NOMBRE APELLIDO:",size:letra_sm-1 
	  pdf.text "CI:",size:letra_sm-1
	  pdf.text "SELLO:",size:letra_sm-1 
	end 

	pdf.bounding_box([240,posicion], :width => 200) do 
	  pdf.text "REVISASDO POR :",size:letra_sm-1 
	  pdf.text "NOMBRE APELLIDO:",size:letra_sm-1 
	  pdf.text "CI:",size:letra_sm-1 
	end 

	pdf.bounding_box([480,posicion], :width => 200) do 
	  pdf.text "APROBADO POR :",size:letra_sm-1  
	  pdf.text "NOMBRE APELLIDO:",size:letra_sm-1 
	  pdf.text "CI:",size:letra_sm-1 
	  pdf.text "SELLO:",size:letra_sm-1 
	end 

	######################################################################################## 
	pdf.bounding_box([0,pdf.cursor], :width => 720) do 
		pdf.text_box "NOTA : Las solicitudes de disponibilidad deben consígnarse con el presupuesto ó cotización corresponíente, debidamente autorizada por el Gerente General.",size:letra_sm-2, :valign => :bottom
	end 

	pdf.page_count().times do |i|
		pdf.go_to_page i 
	    pdf.number_pages "<page> de <total> .", :align => :right ,:size => letra_sm-1, :valign => :bottom , :at => [pdf.bounds.width-170,30]
	end 

end


