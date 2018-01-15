json.extract! pieza, :id, :montaje_id, :nombre, :tamano, :tipo_de_unidad, :dimension, :descripcion, :cantidad, :estado, :created_at, :updated_at
json.url pieza_url(pieza, format: :json)
