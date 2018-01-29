class DesarrolloDeTinta < ApplicationRecord
  belongs_to :orden_produccion
  belongs_to :linea_de_color
  belongs_to :malla
end
