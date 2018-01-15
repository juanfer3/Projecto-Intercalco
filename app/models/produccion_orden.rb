class ProduccionOrden < ApplicationRecord
  belongs_to :cliente
  belongs_to :user
  belongs_to :maquina
  belongs_to :montaje
  belongs_to :pieza_a_decorar
end
