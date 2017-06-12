json.array!(@sigesp_solicituds) do |sigesp_solicitud|
  json.extract! sigesp_solicitud, :id, :codemp, :numsol, :codtipsol, :coduniadm, :codfuefin, :fecregsol, :estsol, :consol, :monto, :monbasinm, :montotcar, :tipo_destino, :cod_pro, :ced_bene, :firnivsol, :firnivadm, :firnivpre, :estapro, :fecaprsep, :codaprusu, :numpolcon, :fechaconta, :fechaanula, :monbasinmaux, :montotcaraux, :montoaux, :undadm, :destino, :cod_servicio, :cod_sede, :cod_region, :str_codregionsedeservicio
  json.url sigesp_solicitud_url(sigesp_solicitud, format: :json)
end
