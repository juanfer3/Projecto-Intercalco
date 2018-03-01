class AddCamposToContenedoresDeMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_reference :contenedores_de_maquinas, :montaje, foreign_key: true
  end
end
