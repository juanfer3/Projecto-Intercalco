json.extract! pedido, :id, :contacto_id, :factura_id, :despacho_id, :producto, :tipo_de_trabajo, :condicion_de_pedido, :fecha_entrega, :fecha_de_pedido, :numero_cotizacion, :numero_de_pedido, :linea_de_impresion_id, :forma_de_pago, :arte, :descripcion, :estado_pedido, :estado, :created_at, :updated_at
json.url pedido_url(pedido, format: :json)
