json.extract! remision, :id, :factura_despacho_id, :tiempos_de_entrega_id, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :entrega_cumplida, :estado, :created_at, :updated_at
json.url remision_url(remision, format: :json)
