class FacturaDespacho < ApplicationRecord
  belongs_to :pedido

  has_many :remisiones, inverse_of: :factura_despacho, dependent: :destroy
  accepts_nested_attributes_for :remisiones, reject_if: :all_blank, allow_destroy: true

end
