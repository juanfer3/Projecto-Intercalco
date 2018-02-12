class ContenedorDeRemision < ApplicationRecord
  belongs_to :contenedor_de_ordenes
  belongs_to :compromiso_de_entrega
end
