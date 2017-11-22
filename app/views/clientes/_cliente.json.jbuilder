json.extract! cliente, :id, :nombre, :nit, :direccion, :telefono, :correo, :user_id, :estado, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
