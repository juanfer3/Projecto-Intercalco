json.extract! nombre_facturacion, :id, :cliente_id, :nombre, :direccion, :telefono, :created_at, :updated_at
json.url nombre_facturacion_url(nombre_facturacion, format: :json)
