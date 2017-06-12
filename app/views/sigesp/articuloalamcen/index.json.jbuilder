json.array!(@alamcenearticulos) do |alamacenarticulo|
  json.extract! alamacenarticulo, :codart , :codalm , :existencia, :articulo ,:almacen
end

