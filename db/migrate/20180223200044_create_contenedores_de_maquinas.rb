class CreateContenedoresDeMaquinas < ActiveRecord::Migration[5.1]
  def change
    create_table :contenedores_de_maquinas do |t|
      t.references :orden_produccion, foreign_key: true
      t.references :maquina, foreign_key: true

      t.timestamps
    end
  end
end
