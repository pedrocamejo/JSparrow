json.array!(@unidades) do |unidad|
  json.extract! unidad, :coduniadm, :codestpro1, :codestpro2, :codestpro3, :codestpro4, :codestpro5, :estcla
  json.extract! unidad.unidad, :coduniadm, :denuniadm, :estemireq
end


