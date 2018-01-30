class LineaDeColor < ApplicationRecord
  has_many :desarrollos_de_tintas, inverse_of: :linea_de_color, dependent: :destroy
  accepts_nested_attributes_for :desarrollos_de_tintas, reject_if: :all_blank, allow_destroy: true
end
