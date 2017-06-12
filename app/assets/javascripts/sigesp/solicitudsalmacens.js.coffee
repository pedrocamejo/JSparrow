
class SolicitudAlmacen
  cargar_sedes: (e) ->
    $("#solicitud_cod_sede").empty();
    $("#solicitud_cod_servicio").empty();
    data =
      url: "/sigesp/sedes"
      type: 'GET'
      data: { region: $(e).val() }
      dataType: 'JSON'
      success: (data) ->
        sede = $('#solicitud_cod_sede')
        sede.empty()
        sede.append $("<option>",{value:""}).append('Seleccione')
        for element in data
          option = $('<option/>',{
            value:element.str_codsede
          })
          option.append element.str_descripcion 
          sede.append option 
        return 
    $.ajax data


  cargar_servicios: (e) ->
    $("#solicitud_cod_servicio").empty();
    data =
      url: "/sigesp/servicios"
      type: 'GET'
      data: { sede: $(e).val() }
      dataType: 'JSON'
      success: (data) ->
        servicio = $('#solicitud_cod_servicio')
        servicio.empty()
        servicio.append $("<option>",{value:""}).append('Seleccione')
        for element in data
          option = $('<option/>',{
            value:element.str_codservicio
          })
          option.append element.str_descripcion 
          servicio.append option 
        return 
    $.ajax data

  cargar_catalogo: (elemento) ->
    editar = $(elemento).data('editar')
    almacen = $(elemento).data('almacen')
    numsol = $(elemento).data('numsol')
    datos= {
      editar: editar,
      almacen: almacen,
      numsol: numsol
    }
    $.getScript("/sigesp/articulos_almacen.js"+"?"+decodeURIComponent($.param(datos)));  

  agregar_articulo: (cod_item)->   
    codigo = $("#catalago").find("##{cod_item.trim()}");
    option = codigo.find('#alamcen option:selected')
    codigo_almacen = option.val()
    data = {
      almacen_id:  codigo_almacen,
      articulo_id: cod_item
    }
    _self = this 
    console.log "/sigesp/articulos/almacen/?#{decodeURIComponent($.param(data))}"
    data =
      url: "/sigesp/articulos/almacen/?#{decodeURIComponent($.param(data))}"
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        #validar que este codigo exista
        if _self.validar_articulo(data)
          articulos = _self.articulos_cargados()
          art=
            codart: data.articulo.codart
            codalm: data.almacen.codalm
            denart: data.articulo.denart
            exiart: data.existencia 
            unidad: data.articulo.denunimed
            desalm: data.almacen.almacen
            cantidad: 1
          articulos.push(art)
          _self.dibujar_articulos(articulos)
          alert "#{art.denart} Agregado Correctamente."
        return 
    $.ajax data

  articulos_cargados: ()->
    articulos = $("#detalle_articulos_solicitud").find("tr")
    _articulos = []
    $.each(articulos,(i,e) ->  
      cantidad = parseFloat($(e).find('.cantidad').val() || 1 )
      exiart   = parseFloat($(e).data('exiart'))
      art =
        codart: $(e).data('codart')
        codalm: $(e).data('codalm')
        denart: $(e).data('denart')
        exiart: exiart
        unidad: $(e).data('unidad')
        desalm: $(e).data('desalm')
        cantidad: if cantidad > exiart then exiart else cantidad
      _articulos.push(art)
    )
    return _articulos 

  dibujar_articulos: (articulos)-> 
    $("#detalle_articulos_solicitud").empty()
    $.each(articulos,(i,e) ->  
      $("#detalle_articulos_solicitud").append("""
      <tr id='#{e.codart}'
        data-codart=\"#{e.codart}\"
        data-codalm=\"#{e.codalm}\"
        data-denart=\"#{e.denart}\"
        data-exiart=\"#{e.exiart}\"
        data-unidad=\"#{e.unidad}\"
        data-desalm=\"#{e.desalm}\" >
        <td>#{e.codart}</td>
        <td>#{e.denart}</td>
        <td><input class="cantidad" max="#{e.exiart}" min="1" value="#{e.cantidad.toFixed(2)}" type="number" step="0.01"></td>
        <td>#{e.unidad}</td>
        <td>#{e.desalm}</td>
        <td>#{e.exiart.toFixed(2)}</td>
        <td><button class="btn btn-danger btn-sm" 
            name="button"
            onclick="solicitudAlmacen.quitarProducto('#{e.codart}')"
            type="button">Quitar</button>
        </td>
      </tr>""");
    )
    #console.log "dibujo"
    return

  validar_articulo: (codigo)->
    if codigo.existencia == 0 
      alert "No hay existencia, en dicho almacen del articulo seleccionado"
      return false 
    articulos = this.articulos_cargados();
    i = 0
    while i < articulos.length
      #console.log "#{codigo.articulo.codart}<-->#{articulos[i].codart}<- "
      if(codigo.articulo.codart == articulos[i].codart) 
        return false 
      i++ 
    return true  

  quitarProducto: (codigo) ->
    articulos = this.articulos_cargados();
    element = null 
    i = 0
    while i < articulos.length
      if(codigo == articulos[i].codart) 
        element = articulos[i]
        break;
      i++
    if element
      articulos.splice(articulos.indexOf(element),1)
     this.dibujar_articulos(articulos)      

  guardar: (e,formulario)->
    e.preventDefault()
    url = $(formulario).attr("action")
    metodo = $(formulario).data("metodo")
    articulos = this.articulos_cargados()
    
    data= 
      cod_region: $("#solicitud_cod_region").val()
      cod_sede: $("#solicitud_cod_sede").val()
      cod_servicio:  $("#solicitud_cod_servicio").val()
      consol: $("#solicitud_consol").val()
      codtipsol:  "01"
      articulos_attributes: []

    $.each(articulos, (i,e) ->   
      data.articulos_attributes.push({
        codart: e.codart,
        codalm: e.codalm,
        canart: e.cantidad
        })
    ); 
    if(this.validar(data,articulos))
      $.ajax({
        type: metodo
        url: url
        contentType: "application/json; charset=utf-8"
        data:JSON.stringify({
          solicitud: data 
        }),
        dataType: "JSON",
        success: (response )->
          #console.log response 
          Turbolinks.visit(response.url)
        error: (obj) ->
          console.log obj 
      });

  validar: (data,articulos)->
    if data.cod_region.trim() == ""  
      alert "Seleccione la Region "
      return false 

    if data.cod_sede.trim() == ""  
      alert "Seleccione la Sede "
      return false 

    if data.cod_servicio.trim() == "" 
      alert "Seleccione el Servicio "
      return false 

    if data.consol.trim() == "" 
      alert "Ingrese Concepto"
      return false 

    if articulos.length == 0 
      alert "Ingrese articulos "
      return false 

    $.each(articulos, (i,e)->
      if e.cantidad <= 0 or e.cantidad > e.exiart
        alert "Error, La cantidad del Articulo #{e.denart} es mayor que la disponible #{e.exiart}."
        return false 
    )
    return true 


@solicitudAlmacen = new SolicitudAlmacen();

