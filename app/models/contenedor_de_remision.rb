class ContenedorDeRemision < ApplicationRecord
  belongs_to :factura
  belongs_to :compromiso_de_entrega
end
