json.extract! proceso_maquinas, :id, :orden_produccion_id, :contenedor_de_maquinas_id, :cerrado, :created_at, :updated_at
json.url proceso_maquinas_url(proceso_maquinas, format: :json)
