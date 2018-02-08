json.extract! factura, :id, :orden_produccion_id, :numero_de_factura, :iva, :descuento, :total_facturado, :cancelada, :created_at, :updated_at
json.url factura_url(factura, format: :json)
