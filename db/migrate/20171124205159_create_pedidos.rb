class CreatePedidos < ActiveRecord::Migration[5.1]
  def change
    create_table :pedidos do |t|
      t.references :contacto, foreign_key: true
      t.string :producto
      t.string :tipo_de_trabajo
      t.string :condicion_de_pedido
      t.date :fecha_entrega
      t.date :fecha_de_pedido
      t.string :numero_cotizacion
      t.string :numero_de_pedido
      t.references :linea_de_impresion, foreign_key: true
      t.string :forma_de_pago
      t.string :arte
      t.string :descripcion
      t.string :estado_pedido
      t.string :total_articulo
      t.boolean :estado

      t.timestamps
    end
  end
end
