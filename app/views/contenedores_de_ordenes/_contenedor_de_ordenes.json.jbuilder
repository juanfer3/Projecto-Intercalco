json.extract! contenedor_de_ordenes, :id, :factura_id, :orden_produccion_id, :created_at, :updated_at
json.url contenedor_de_ordenes_url(contenedor_de_ordenes, format: :json)
