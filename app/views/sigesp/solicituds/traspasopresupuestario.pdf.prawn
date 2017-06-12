prawn_document(:force_download=>true,:page_size => "LETTER",:left_margin => 50,	
:right_margin => 50 ) do |pdf|
 	letra_sm = 11
	pdf.repeat :all do
		pdf.bounding_box([0,740], :width => 70, :height => 100) do
			image = "#{Rails.root}/app/assets/images/logocvalpc.png"
			pdf.image image, :at => [10,50]
	  	end
		pdf.bounding_box([150,660], :width => 240, :height => 100) do
			texto = " CVA CIA MECANIZADO AGRICOLA Y TRANSPORTE PEDRO CAMEJO S.A. RIF G-200079100"
			pdf.text texto, :size => 14 , :align=> :center , :valign => :center
	  	end
		pdf.bounding_box([270,680], :width => 240, :height => 75) do
	    	texto = "Nro: #{@solicitud.numsol}"
	    	pdf.text_box texto, :align => :right, :size => letra_sm-2,
			  	 :valign => :top , :inline_format => true
	  	end
		pdf.bounding_box([0,pdf.bounds.height - 140], :width => 540, :height => 14) do 
			texto = " 	Solicitud de Traspaso Presupuestario."
			pdf.text texto, :size => letra_sm , :align=> :center , :valign => :center
		end
 	end
	pdf.bounding_box([0,pdf.bounds.height - 180], :width => 540, :height => 200 ) do 
		valor = """Para: Lic. Elizabeth Fonseca / Director(a) De Planificación y Presupuesto.
				De : #{@solicitud.unidad.denuac}.
				Asunto: Lo indica en el Texto.
		""" 
		pdf.text valor, :size => letra_sm ,:leading => 2.5 
	end
	pdf.bounding_box([0,pdf.bounds.height - 250], :width => 500, :height => 400 ) do 
		valor = """	\tReciba ante todo un cordial saludo Revolucionario extensivo al equipo de trabajo que lo acompaña. Por medio de la presente se solicita el Traspaso presupuestario para contar con la  disponibilidad de cubrir la adquisicion de bienes o servicios que se especifican en la Requisición #{@solicitud.numsol}, el cual tiene como concepto: #{@solicitud.consol}

		Sin mas a que hacer referencia. Se Despide
		"""
			pdf.text  valor, :size => letra_sm ,:align => :justify,:leading => 1.5, :indent_paragraphs => 10
	end

	posicion = pdf.cursor
	pdf.bounding_box([0,posicion+60], :width => 540, :height => 60) do 
			valor = "Atentamente"
			pdf.text  valor, :size => letra_sm ,:align => :center
		 	pdf.stroke  do
			  pdf.line_width 1
			  pdf.horizontal_line(180,400,:at =>10 )
			end
	end

	pdf.bounding_box([0,posicion  ], :width => 240, :height => 100) do 
		valor = """ Nombre :
			C.I :
			Cargo :	"""
			pdf.text valor, :size => letra_sm ,:align => :center
	end

	pdf.page_count().times do |i|
		pdf.go_to_page i 
	  pdf.number_pages "<page> de <total> ", :align => :right ,
	  	 :size => letra_sm-4, :valign => :bottom , :at => [pdf.bounds.width-170,30]
	end 

end
