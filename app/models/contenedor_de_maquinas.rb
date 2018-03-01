class ContenedorDeMaquinas < ApplicationRecord
  belongs_to :montaje
  belongs_to :maquina
end
