class FacturaDespacho < ApplicationRecord
  belongs_to :tiempos_de_entrega

  has_many :remisiones, inverse_of: :factura_despacho, dependent: :destroy
  accepts_nested_attributes_for :remisiones, reject_if: :all_blank, allow_destroy: true

end
