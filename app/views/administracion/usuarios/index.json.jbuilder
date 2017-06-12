json.array!(@administracion_usuarios) do |administracion_usuario|
  json.extract! administracion_usuario, :id
  json.url administracion_usuario_url(administracion_usuario, format: :json)
end
