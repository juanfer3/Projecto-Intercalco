json.extract! detalle_de_produccion, :id, :orden_de_produccion_id, :codigo, :descripcion, :cantidad, :fecha, :inventario, :estado, :created_at, :updated_at
json.url detalle_de_produccion_url(detalle_de_produccion, format: :json)
