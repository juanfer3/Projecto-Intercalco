class RemoveCampoOrdenToContenedoresDeMaquinas < ActiveRecord::Migration[5.1]
  def change
    remove_reference :contenedores_de_maquinas, :orden_produccion, foreign_key: true
  end
end
