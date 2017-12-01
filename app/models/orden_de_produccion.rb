class OrdenDeProduccion < ApplicationRecord
  belongs_to :pedido

  has_many :detalles_de_produccion, inverse_of: :orden_de_produccion, dependent: :destroy
  accepts_nested_attributes_for :detalles_de_produccion, reject_if: :all_blank, allow_destroy: true

end
