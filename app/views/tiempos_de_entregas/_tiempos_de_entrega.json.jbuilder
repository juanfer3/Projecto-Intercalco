json.extract! tiempos_de_entrega, :id, :pedido_id, :remision, :cantidad, :fecha_compromiso, :precio, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :anexo, :entrega_cumplida, :estado, :created_at, :updated_at
json.url tiempos_de_entrega_url(tiempos_de_entrega, format: :json)
