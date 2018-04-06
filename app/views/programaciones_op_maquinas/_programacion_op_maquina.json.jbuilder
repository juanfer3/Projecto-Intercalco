json.extract! programacion_op_maquina, :id, :orden_produccion_id, :maquina_id, :total_hora, :hora_inicio, :hora_final, :cantidad_maquinas, :tiempo_por_maquina, :tiempo_de_montaje, :tiempo_de_desmontaje, :habilitado, :complemento, :created_at, :updated_at
json.url programacion_op_maquina_url(programacion_op_maquina, format: :json)
