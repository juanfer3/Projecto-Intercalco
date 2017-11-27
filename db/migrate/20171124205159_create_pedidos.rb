class CreatePedidos < ActiveRecord::Migration[5.1]
  def change
    create_table :pedidos do |t|
      t.references :contacto, foreign_key: true
      t.string :producto, default: ""
      t.string :tipo_de_trabajo, default: ""
      t.string :condicion_de_pedido, default: ""
      t.date :fecha_entrega
      t.date :fecha_de_pedido
      t.string :numero_cotizacion, default: ""
      t.string :numero_de_pedido, default: ""
      t.references :linea_de_impresion, foreign_key: true
      t.string :forma_de_pago, default: ""
      t.string :arte, default: ""
      t.string :descripcion, default: ""
      t.string :estado_pedido, default: "Pedido"
      t.string :total_articulo, default: ""
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
