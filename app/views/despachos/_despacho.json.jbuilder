json.extract! despacho, :id, :pedido_id, :nombre, :nit, :telefono, :lugar_de_despacho, :direccion, :celular, :correo, :recibe, :observacion, :facturar, :estado, :created_at, :updated_at
json.url despacho_url(despacho, format: :json)
