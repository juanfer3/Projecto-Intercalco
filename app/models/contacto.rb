class Contacto < ApplicationRecord
  belongs_to :cliente
  belongs_to :user

  has_many :ordenes_produccion, inverse_of: :contacto, dependent: :destroy
  accepts_nested_attributes_for :ordenes_produccion, reject_if: :all_blank, allow_destroy: true
end
