class DesarrolloDeTinta < ApplicationRecord
  belongs_to :montaje
  belongs_to :linea_de_color
  belongs_to :malla
end
