json.extract! user, :id, :nombre, :numero_celular, :rol_id, :estado, :created_at, :updated_at
json.url user_url(user, format: :json)
