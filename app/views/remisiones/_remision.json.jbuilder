json.extract! remision, :id, :factura_despacho_id, :numero_de_remision, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :entrega_cumplida, :estado, :created_at, :updated_at
json.url remision_url(remision, format: :json)
