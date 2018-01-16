json.extract! mes, :id, :nombre, :dias, :observacion, :estado, :created_at, :updated_at
json.url mes_url(mes, format: :json)
