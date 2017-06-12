json.array!(@tiposarticulos) do |tipo|
  json.extract! tipo, :codtipart, :dentipart
end