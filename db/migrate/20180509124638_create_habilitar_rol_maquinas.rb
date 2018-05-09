class CreateHabilitarRolMaquinas < ActiveRecord::Migration[5.1]
  def change
    create_table :habilitar_rol_maquinas do |t|
      t.references :maquina, foreign_key: true
      t.references :rol, foreign_key: true

      t.timestamps
    end
  end
end
