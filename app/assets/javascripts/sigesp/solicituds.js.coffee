# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


class SolicitudPresupuesto

  cargarUnidadAdministrativas: (e) ->
    $("#sigesp_solicitud_coduniadm").empty();
    $("#codigopresupuestario").empty()
    data =
      url: $(e).data("url")
      type: 'GET'
      data: { fuenteFinanciamiento: $(e).val() }
      dataType: 'JSON'
      success: (data) ->
        s = $('#sigesp_solicitud_coduniadm')
        s.empty()
        s.append $("<option>",{value:""}).append('Seleccione')
        for element in data
          option = $('<option/>',{
            value:element.coduniadm
            'data-codestpro1':element.codestpro1
            'data-codestpro2':element.codestpro2
            'data-codestpro3':element.codestpro3
            'data-codestpro4':element.codestpro4
            'data-codestpro5':element.codestpro5
          })
          option.append element.denuniadm 
          s.append option 
        return 
    $.ajax data

  inicializar: (e)->
    $("#sigesp_solicitud_coduniadm").change ()->
      option = $('#sigesp_solicitud_coduniadm option:selected')
      codestpro1 = option.data('codestpro1')
      codestpro2 = option.data('codestpro2')
      codestpro3 = option.data('codestpro3')
      codestpro4 = option.data('codestpro4')
      codestpro5 = option.data('codestpro5')
      $('#codestpro1').val(codestpro1)
      $('#codestpro2').val(codestpro2)
      $('#codestpro3').val(codestpro3)
      $('#codestpro4').val(codestpro4)
      $('#codestpro5').val(codestpro5)
      $('#codigopresupuestario').empty()
      $('#codigopresupuestario').append(codestpro1+"--"+codestpro2+"--"+codestpro3+"--"+codestpro4+"--"+codestpro5)

@solicitudPresupuesto = new SolicitudPresupuesto() 

 

class Solicitud
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

  cargar_catalogo_articulos: (elemento) ->
    $.getScript("/sigesp/articulos.js"+"?");  

  cargar_catalogo_servicios: (elemento) ->
    $.getScript("/sigesp/servicios_solictud.js"+"?");  

  agregar_servicio: (cod_item)-> 
    data = {
      servicio_id: cod_item
    }
    _self = this 
    data =
      url: "/sigesp/servicios_solictud/detalle.json?#{decodeURIComponent($.param(data))}"
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        servicios = _self.servicios_cargados()
        if _self.validar_servicio(servicios,data)
          ser=
            codser: data.servicio.codser
            denser: data.servicio.denser
            unidad: data.servicio.denunimed
            cantidad: 1
            precio: 0
            total:  0
            porcar: data.servicio.cargo_activo.porcar
          servicios.push(ser)
          _self.dibujar_servicios(servicios)
          alert "#{art.denser} Agregado Correctamente."
        return 
    $.ajax data

  validar_servicio: (servicios,codigo)->
    if codigo.servicio.cargo_activo?
      i = 0
      while i < servicios.length
        if(codigo.servicio.codser == servicios[i].codser) 
          return false 
        i++ 
      return true  
    else
      alert "Este Articulo no posee Cargo Activo "
      return false  


  agregar_articulo: (cod_item)->   
    data = {
      articulo_id: cod_item
    }
    _self = this 
    data =
      url: "/sigesp/articulo_detalle.json?#{decodeURIComponent($.param(data))}"
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        articulos = _self.articulos_cargados()
        if _self.validar_articulo(articulos,data)
          art=
            codart: data.articulo.codart
            denart: data.articulo.denart
            exiart: data.articulo.exiart 
            unidad: data.articulo.denunimed
            cantidad: 1
            precio: data.articulo.ultcosartaux
            total:  data.articulo.ultcosartaux
            porcar: data.articulo.cargo_activo.porcar
          articulos.push(art)
          _self.dibujar_articulos(articulos)
          alert "#{art.denart} Agregado Correctamente."
        return 
    $.ajax data


  servicios_cargados: ()->
    servicios = $("#detalle_servicios_solicitud").find("tr")
    _servicios = []
    $.each(servicios,(i,e) ->  
      cantidad = parseFloat($(e).find('.cantidad').val() || 1 )
      precio   = parseFloat($(e).find('.precio').val() || 1 )
      ser =
        codser: $(e).data('codser')
        denser: $(e).data('denser')
        unidad: $(e).data('unidad')
        porcar: $(e).data('porcar')
        cantidad: cantidad
        precio: precio
        total: cantidad * precio
      _servicios.push(ser)
    )
    return _servicios 


  articulos_cargados: ()->
    articulos = $("#detalle_articulos_solicitud").find("tr")
    _articulos = []
    $.each(articulos,(i,e) ->  
      cantidad = parseFloat($(e).find('.cantidad').val() || 1 )
      precio   = parseFloat($(e).find('.precio').val() || 1 )
      exiart   = parseFloat($(e).data('exiart'))
      art =
        codart: $(e).data('codart')
        denart: $(e).data('denart')
        exiart: exiart
        unidad: $(e).data('unidad')
        porcar: $(e).data('porcar')
        cantidad: cantidad  #if cantidad > exiart then exiart else cantidad
        precio: precio
        total: cantidad * precio
      _articulos.push(art)
    )
    return _articulos 

  dibujar_servicios: (servicios)-> 
    $("#detalle_servicios_solicitud").empty()
    sum = 0 
    cargo = 0 
    if $("#formulario").data('compra') == true
      $.each(servicios,(i,e) ->  
        sum += e.cantidad * e.precio
        cargo += (e.cantidad * e.precio) * (e.porcar /100)
        $("#detalle_servicios_solicitud").append("""
        <tr id='#{e.codser}'
          data-codser="#{e.codser}"
          data-denser="#{e.denser}"
          data-unidad="#{e.unidad}"
          data-porcar="#{e.porcar}" >
          <td style="width: 10%">#{e.codser}</td>
          <td style="width: 30%">#{e.denser}</td>
          <td style="width: 15%">
            <input class="cantidad" 
                min="1"
                value="#{e.cantidad.toFixed(2)}"
                type="number"
                step="0.01"
                onchange="solicitud.actualizar_monto_servicios()">
          </td>
          <td style="width: 15%">
            <input class="precio"
              min="1"
              value="#{e.precio.toFixed(2)}"
              type="number"
              step="0.01"
              onchange="solicitud.actualizar_monto_servicios()">
          </td>
          <td style="width: 15%">#{$.number(e.total,2,',','.')}</td>
          <td style="width: 10%">#{e.unidad}</td>
          <td style="width: 5%; align-content:center">
            <button class="btn btn-danger btn-xs" 
              name="button"
              onclick="solicitud.quitarServicio('#{e.codser}')"
              type="button">Quitar</button>
          </td>
        </tr> """);
      );
      $("#formulario #monto").empty().append("#{$.number(sum,2,',','.')} Bs")
      $("#formulario #cargo").empty().append("#{$.number(cargo,2,',','.')} Bs")
      $("#formulario #total").empty().append("#{$.number(parseFloat(sum + cargo),2,',','.')} Bs")
    else 
      $.each(servicios,(i,e) ->  
        $("#detalle_servicios_solicitud").append("""
        <tr id='#{e.codser}'
          data-codser="#{e.codser}"
          data-denser="#{e.denser}"
          data-unidad="#{e.unidad}"
          data-porcar="#{e.porcar}" >
          <td style="width: 10%">#{e.codser}</td>
          <td style="width: 40%">#{e.denser}</td>
          <td style="width: 20%"><input class="cantidad" min="1" value="#{e.cantidad.toFixed(2)}" type="number" step="0.01"></td>
          <td style="width: 20%">#{e.unidad}</td>
          <td style="width: 5%; align-content:center">
            <button class="btn btn-danger btn-xs" 
              name="button"
              onclick="solicitud.quitarServicio('#{e.codser}')"
              type="button">Quitar</button>
          </td>
        </tr>""");
      );

    return

  dibujar_articulos: (articulos)-> 
    $("#detalle_articulos_solicitud").empty()
    sum = 0 
    cargo = 0 
    if $("#formulario").data('compra') == true
      $.each(articulos,(i,e) ->  
        sum += e.cantidad * e.precio
        cargo += (e.cantidad * e.precio) * (e.porcar /100)
        $("#detalle_articulos_solicitud").append("""
        <tr id='#{e.codart}'
          data-codart="#{e.codart}"
          data-denart="#{e.denart}"
          data-exiart="#{e.exiart}"
          data-unidad="#{e.unidad}"
          data-porcar="#{e.porcar}"
          >
          <td style="width: 10%">#{e.codart}</td>
          <td style="width: 20%">#{e.denart}</td>
          <td style="width: 15%">
            <input class="cantidad"
              min="1"
              value="#{e.cantidad.toFixed(2)}"
              type="number"
              step="0.01"
              onchange="solicitud.actualizar_monto()">
          </td>
          <td style="width: 15%">
            <input class="precio"
              min="1"
              value="#{e.precio.toFixed(2)}"
              type="number"
              step="0.01"
              onchange="solicitud.actualizar_monto()">
          </td> 
          <td style="width: 15%">#{$.number(e.total,2,',','.')}</td>
          <td style="width: 10%">#{e.unidad}</td>
          <td style="width: 10%">#{e.exiart.toFixed(2)}</td>
          <td><button class="btn btn-danger btn-sm" 
              name="button"
              onclick="solicitud.quitarProducto('#{e.codart}')"
              type="button">Quitar</button>
          </td>
        </tr>""");
      );
      $("#formulario #monto").empty().append("#{$.number(sum,2,',','.')} Bs")
      $("#formulario #cargo").empty().append("#{$.number(cargo,2,',','.')} Bs")
      $("#formulario #total").empty().append("#{$.number(parseFloat(sum + cargo),2,',','.')} Bs")
    else 
      $.each(articulos,(i,e) ->  
        $("#detalle_articulos_solicitud").append("""
        <tr id='#{e.codart}'
          data-codart=\"#{e.codart}\"
          data-denart=\"#{e.denart}\"
          data-exiart=\"#{e.exiart}\"
          data-unidad=\"#{e.unidad}\">
          <td style=\"width: 10%\">#{e.codart}</td>
          <td style=\"width: 35%\">#{e.denart}</td>
          <td style=\"width: 20%\"><input class="cantidad" min="1" value="#{e.cantidad.toFixed(2)}" type="number" step="0.01"></td>
          <td style=\"width: 20%\">#{e.unidad}</td>
          <td style=\"width: 10%\">#{e.exiart.toFixed(2)}</td>
          <td><button class="btn btn-danger btn-sm" 
              name="button"
              onclick="solicitud.quitarProducto('#{e.codart}')"
              type="button">Quitar</button>
          </td>
        </tr>""");
       );

    return

  validar_articulo: (articulos,codigo)->
    if codigo.articulo.cargo_activo?
      i = 0
      while i < articulos.length
        if(codigo.articulo.codart == articulos[i].codart) 
          return false 
        i++ 
      return true  
    else
      alert "Este Articulo no posee Cargo Activo "
      return false  

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

  quitarServicio: (codigo)->
    servicios = this.servicios_cargados();
    element = null 
    i = 0
    while i < servicios.length
      if(codigo == servicios[i].codser) 
        element = servicios[i]
        break;
      i++
    if element
      servicios.splice(servicios.indexOf(element),1)
     this.dibujar_servicios(servicios)      

  guardar: (e,formulario)->
    e.preventDefault()
    url = $(formulario).attr("action")
    metodo = $(formulario).data("metodo")

    if( $(formulario).data('codtipsol') == '02')
      servicios = this.servicios_cargados()
      data= 
        cod_region: $("#solicitud_cod_region").val()
        cod_sede: $("#solicitud_cod_sede").val()
        cod_servicio:  $("#solicitud_cod_servicio").val()
        consol: $("#solicitud_consol").val()
        codtipsol:  "02"
        servicios_attributes: []
      $.each(servicios, (i,e) ->   
        data.servicios_attributes.push({
          codser: e.codser
          canser: e.cantidad
          })
      ); 
      if(this.validar_servicios(data,servicios))
        $.ajax({
          type: metodo
          url: url
          contentType: "application/json; charset=utf-8"
          data:JSON.stringify({
            solicitud: data 
          }),
          dataType: "JSON",
          success: (response )->
            Turbolinks.visit(response.url)
          error: (obj) ->
            console.log obj 
        });
    else
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
          codart: e.codart
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
            Turbolinks.visit(response.url)
          error: (obj) ->
            console.log obj 
        });

  guardar_compra: (e,formulario)->
    e.preventDefault()
    url = $(formulario).attr("action")
    metodo = $(formulario).data("metodo")
    if( $(formulario).data('codtipsol') == '02')
      servicios = this.servicios_cargados()
      data= 
        cod_region: $("#solicitud_cod_region").val()
        cod_sede: $("#solicitud_cod_sede").val()
        cod_servicio:  $("#solicitud_cod_servicio").val()
        consol: $("#solicitud_consol").val()
        codtipsol:  "02"
        servicios_attributes: []
      $.each(servicios, (i,e) ->   
        data.servicios_attributes.push({
          codser: e.codser
          canser: e.cantidad
          monpre: e.precio
          })
      ); 
      if(this.validar_servicios_compra(data,servicios))
        $.ajax({
          type: metodo
          url: url
          contentType: "application/json; charset=utf-8"
          data:JSON.stringify({
            solicitud: data 
          }),
          dataType: "JSON",
          success: (response )->
            Turbolinks.visit(response.url)
          error: (obj) ->
            console.log obj 
        });
    else
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
          codart: e.codart
          canart: e.cantidad
          monpre: e.precio
          })
      ); 
      if(this.validar_compra(data,articulos))
        $.ajax({
          type: metodo
          url: url
          contentType: "application/json; charset=utf-8"
          data:JSON.stringify({
            solicitud: data 
          }),
          dataType: "JSON",
          success: (response )->
            Turbolinks.visit(response.url)
          error: (obj) ->
            console.log obj 
        });

  validar_compra: (data,articulos)->
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
      if e.cantidad < 1 
        alert "Error, La cantidad del Articulo #{e.denart}."
        return false 

      if e.precio < 1 
        alert "Error, el Precio del Articulo #{e.denart} es invalido."
        return false 

    )
    return true 

  validar_servicios_compra:  (data,servicios)->
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

    if servicios.length == 0 
      alert "Ingrese servicios "
      return false 

    $.each(servicios, (i,e)->
      if e.cantidad < 1 
        alert "Error, La cantidad del Servicio #{e.denser}."
        return false 

      if e.precio < 1 
        alert "Error, el Precio del Servicio #{e.denser} es invalido."
        return false 
    )
    return true 


  validar_servicios: (data,servicios)->
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

    if servicios.length == 0 
      alert "Ingrese servicios "
      return false 

    $.each(servicios, (i,e)->
      if e.cantidad < 1 
        alert "Error, La cantidad del Servicio #{e.denser}."
        return false 
    )
    return true 

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
      if e.cantidad < 1 
        alert "Error, La cantidad del Articulo #{e.denart}."
        return false 
    )
    return true 

  actualizar_monto: ()->
    articulos = this.articulos_cargados()
    this.dibujar_articulos(articulos)

  actualizar_monto_servicios: ()->
    servicios = this.servicios_cargados()
    this.dibujar_servicios(servicios)

@solicitud = new Solicitud();


$(document).on 'show.bs.collapse', '#accordion', (e) ->
  elemento = $(e.target)
  url = elemento.data('url')
  $.getJSON(url, (data ) ->  
    #articulos
    ul = $("<ul><lu>", class: "list-group")
    if data.tipo == 1  
      $.each(data.articulos, ( key, val ) ->
        ul.append("""
         <li class="list-group-item"> #{val.denart}</li>
        """)
      );
    else 
      $.each(data.servicios, ( key, val ) ->
        ul.append("""
         <li class="list-group-item"> #{val.denser}</li>
        """)
      );
    console.log "body_plantilla_#{data.id}"
    $("#body_plantilla_#{data.id}").empty().append(ul)

  );

