class ProcesoMaquinas < ApplicationRecord
  belongs_to :orden_produccion
  belongs_to :contenedor_de_maquinas

  
end
