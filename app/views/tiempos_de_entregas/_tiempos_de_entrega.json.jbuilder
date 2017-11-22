json.extract! tiempos_de_entrega, :id, :pedido_id, :cantidad, :fecha_compromiso, :precio, :estado, :created_at, :updated_at
json.url tiempos_de_entrega_url(tiempos_de_entrega, format: :json)
