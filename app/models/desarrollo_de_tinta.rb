class DesarrolloDeTinta < ApplicationRecord
  belongs_to :montaje
  belongs_to :linea_de_color
  belongs_to :malla

  has_many :transiciones, inverse_of: :desarrollo_de_tinta, dependent: :destroy
  accepts_nested_attributes_for :transiciones, reject_if: :all_blank, allow_destroy: true
end
