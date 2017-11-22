json.extract! contacto, :id, :nombre_contacto, :telefono, :celular, :correo, :cliente_id, :estado, :created_at, :updated_at
json.url contacto_url(contacto, format: :json)
