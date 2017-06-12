prawn_document(:page_layout => :landscape,:force_download=>true) do |pdf|
 	letra_sm = 7

	pdf.repeat :all do
		pdf.bounding_box([0,540], :width => 280, :height => 75) do
		    pdf.stroke_bounds
			image = "#{Rails.root}/app/assets/images/logocvalpc.png"
			pdf.image image, :at => [10,50]
			pdf.text "\nCVA CIA MECANIZADO AGRICOLA Y ", :size => letra_sm+2, :align=> :right ,:leading => 2 
			pdf.text "TRANSPORTE PEDRO CAMEJO S.A. ", :size => letra_sm+2, :align=> :right
			pdf.text "RIF G-200079100.", :size => letra_sm+2, :align=> :right 
	  	end

		pdf.bounding_box([280,540], :width => 200, :height => 75) do
		    pdf.stroke_bounds
			pdf.text "Requisicion" , :size => 24 , :align=> :center , :valign => :center
	  	end

		pdf.bounding_box([480,540], :width => 240, :height => 75) do
	    	pdf.stroke_bounds
	    	texto = "\nNro: #{@solicitud.numsol} \n Fecha : #{@solicitud.fecregsol}."
	    	pdf.text_box texto, :align => :right, :size => letra_sm+6,
			  	 :valign => :top , :inline_format => true
	  	end
		pdf.text_box "\nESPECIFICACIONES" ,:align => :center , :at => [pdf.bounds.left,pdf.bounds.top-115]
 	end # todas las Paginas 


	pdf.bounding_box([0,pdf.bounds.height - 75], :width => 470, :height => 20 ) do 
		pdf.stroke_bounds
		texto = "CONCEPTO #{@solicitud.consol}"
    pdf.text_box texto, :align => :left, :size => letra_sm,
		  	 :valign => :center ,:leading => 1,  :inline_format => true
	end 

	pdf.bounding_box([0,pdf.bounds.height - 95], :width => 470, :height => 20 ) do 
		pdf.stroke_bounds
		texto = "UNIDAD SOLICITANTE #{@solicitud.unidad.denuac}"
    pdf.text_box texto, :align => :left, :size => letra_sm,
		  	 :valign => :center ,:leading => 1,  :inline_format => true
	end 

	pdf.bounding_box([470,pdf.bounds.height - 75], :width => 250, :height => 20 ) do 
		pdf.stroke_bounds
	    pdf.text_box "\nDESTINO : #{@solicitud.destino_solicitud}", :align => :left, :size => letra_sm,
		  	 :valign => :top ,:leading => 1,  :inline_format => true
	end 

	pdf.bounding_box([470,pdf.bounds.height - 95], :width => 250, :height => 20 ) do 
		pdf.stroke_bounds
	    pdf.text_box "\nALMACEN : #{@solicitud.almacen_articulos.nomfisalm}", :align => :left, :size => letra_sm,
		  	 :valign => :top ,:leading => 1,  :inline_format => true
	end 


	titulo = ["Codigo","Fabricante","Cantidad Solicitada","Unidad","descripcion","N° Entregada ","Observaciones "]

	tabla = []
	tabla << titulo 

	@solicitud.articulos.includes(:articulo).references(:articulo).each do |articulo| 
		arr = []
		arr <<  articulo.articulo.codart 
		arr << (articulo.articulo.enriquecido.nil? ? "N/D":articulo.articulo.enriquecido.str_codfabricante ) 
	    arr <<  articulo.canart
	    arr <<  articulo.articulo.unidad.denunimed
	    arr <<  articulo.articulo.denart 
	    arr <<  " "
	    arr <<  " "
	    tabla << arr  
	end

  pdf.bounding_box([pdf.bounds.left,pdf.bounds.top-120], :width => pdf.bounds.width) do
    # Restore the old y-position for the first page
		pdf.table tabla, :header => true , :width => 720  , :column_widths	=> [70,70,50,50,240,50,190],
	:cell_style => {size: letra_sm} , :position => :left 
  end

  # Hay Espacio Suficiente  ? 
  cursor =  pdf.cursor
    if (cursor - 125) < 0 
	  pdf.start_new_page 
	  pdf.move_down 125
	  cursor = pdf.cursor 
    end

	posicion = pdf.cursor-10
  	posicion2 = pdf.cursor-25

	pdf.bounding_box([0,posicion], :width => 240, :height => 15) do 
	  pdf.stroke_bounds
	  pdf.text "REALIZADO POR",size:letra_sm, :align => :center , :valign => :center
	end 

	nombre = @solicitud.usuario.usuario unless @solicitud.usuario.nil?

	pdf.bounding_box([0,posicion2], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\n #{nombre}",size:letra_sm, :align => :left , :valign => :top
	end 

	pdf.bounding_box([120,posicion2], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nFirma" ,size:letra_sm, :align => :left , :valign => :top
	end 

	pdf.bounding_box([240,posicion], :width => 240, :height => 15) do 
	  pdf.stroke_bounds
	  pdf.text "AUTORIZADO POR RESPONSABLE DE LA UNIDAD GERENCIA ", size:letra_sm, :align => :center, :valign => :center
	end 
	
	pdf.bounding_box([240,posicion2], :width => 240, :height => 30) do 
	  pdf.stroke_bounds
	end 

	pdf.bounding_box([480,posicion], :width => 240, :height => 15) do 
	  pdf.stroke_bounds
	  pdf.text "POR GERENCIA ADMINISTRATIVA " ,size:letra_sm, :align => :center , :valign => :center
	end 

	pdf.bounding_box([480,posicion2], :width => 240, :height => 30) do 
    pdf.stroke_bounds
    pdf.text "\nNombres Apellidos " ,size:letra_sm, :align => :left , :valign => :top
	end 
	############################################################################################## 
 	posicion = pdf.cursor-10

	pdf.bounding_box([0,posicion], :width => pdf.bounds.width, :height => 60 ) do 
		pdf.text_box "PARA USO DEL ALMACEN", :align => :center, :valign => :top  ,size:letra_sm 
	
		pdf.bounding_box([0,50], :width => 240, :height => 15) do 
 	   pdf.stroke_bounds
 	   pdf.text "ENTREGADO POR: ",size:letra_sm, :align => :left , :valign => :center
		end 

		pdf.bounding_box([0,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nCI: \n Firma:",size:letra_sm, :align => :left , :valign => :top
		end 

		pdf.bounding_box([120,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nFECHA" ,size:letra_sm, :align => :left , :valign => :top 
		end 


		pdf.bounding_box([240,50], :width => 240, :height => 15) do 
		  pdf.stroke_bounds
		  pdf.text "TRANSPORTADO POR :", size:letra_sm, :align => :left, :valign => :center
		end 

		pdf.bounding_box([240,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nCI: \n Firma:",size:letra_sm, :align => :left , :valign => :top
		end 

		pdf.bounding_box([360,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nFECHA" ,size:letra_sm, :align => :left , :valign => :top 
		end 

		pdf.bounding_box([480,50], :width => 240, :height => 15) do 
 	   pdf.stroke_bounds
 	   pdf.text "RECIBIDO POR :" ,size:letra_sm, :align => :left , :valign => :center
		end 

		pdf.bounding_box([480,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nCI: \n Firma:",size:letra_sm, :align => :left , :valign => :top
		end 

		pdf.bounding_box([600,35], :width => 120, :height => 30) do 
	    pdf.stroke_bounds
	    pdf.text "\nFECHA" ,size:letra_sm, :align => :left , :valign => :top 
		end 
	end 

	######################################################################################## 

	pdf.page_count().times do |i|
		pdf.go_to_page i 
	  pdf.number_pages "<page> de <total> .", :align => :right ,
	  	 :size => letra_sm, :valign => :bottom , :at => [pdf.bounds.width-170,30]
	end 

end
