class Acabado < ApplicationRecord
  has_many :contenedores_de_acabados, inverse_of: :acabado, dependent: :destroy
  accepts_nested_attributes_for :contenedores_de_acabados, reject_if: :all_blank, allow_destroy: true
end
