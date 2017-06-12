class ArticulosAlmacenValidator < ActiveModel::Validator

  def validate(articulo) # recibe un detalle articulo
    unless articulo.almacen.nil?
      articuloAlmacen = Sigesp::ArticuloAlmacen.ArticuloAlmacen(
      		articulo.articulo,articulo.almacen)
      if articulo.canart > articuloAlmacen.existencia
 	    articulo.errors[:cantidad] << "Ingrese una cantidad menor a #{articuloAlmacen.existencia} articulos"
      end 
    else
      if articulo.solicitud.tipo.almacen 
        articulo.errors[:almacen] << "Ingrese Almacen "
      end 
    end
  end


end