json.array!(@administracion_grupos) do |administracion_grupo|
  json.extract! administracion_grupo, :id, :nombre, :estado
  json.url administracion_grupo_url(administracion_grupo, format: :json)
end
