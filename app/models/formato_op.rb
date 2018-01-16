class FormatoOp < ApplicationRecord
  belongs_to :user
  belongs_to :maquina
  belongs_to :montaje
  belongs_to :pieza_a_decorar
  belongs_to :linea_de_color
  belongs_to :linea_producto
end
