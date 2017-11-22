class Pedido < ApplicationRecord
  belongs_to :contacto
  belongs_to :factura
  belongs_to :despacho
  belongs_to :linea_de_impresion
end
