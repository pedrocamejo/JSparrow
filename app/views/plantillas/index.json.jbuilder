json.array!(@plantillas) do |plantilla|
  json.extract! plantilla, :id, :nombre, :descripcion
  json.url plantilla_url(plantilla, format: :json)
end
