class Remision < ApplicationRecord
  belongs_to :factura_despacho
  belongs_to :tiempos_de_entrega
end
