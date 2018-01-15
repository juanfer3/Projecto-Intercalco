json.extract! linea_producto, :id, :nombre, :descripcion, :estado, :created_at, :updated_at
json.url linea_producto_url(linea_producto, format: :json)
