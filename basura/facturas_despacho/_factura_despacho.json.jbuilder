json.extract! factura_despacho, :id, :tiempos_de_entrega_id, :numero_de_factura, :cancelada, :estado, :created_at, :updated_at
json.url factura_despacho_url(factura_despacho, format: :json)
