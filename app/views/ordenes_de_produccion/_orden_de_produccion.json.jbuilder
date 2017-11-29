json.extract! orden_de_produccion, :id, :pedido_id, :numero_de_orden, :descripcion, :fecha_final, :total, :estado, :created_at, :updated_at
json.url orden_de_produccion_url(orden_de_produccion, format: :json)
