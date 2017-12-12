json.extract! factura_despacho, :id, :tiempos_de_entrega_id, :numero_de_factura, :total_facturado, :iva, :descuento, :cancelada, :cantidad_faltante, :total_enviado, :estado, :created_at, :updated_at
json.url factura_despacho_url(factura_despacho, format: :json)
