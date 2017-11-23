class Despacho < ApplicationRecord
  belongs_to :cliente
  
  has_many :pedidos, inverse_of: :depacho, dependent: :destroy
  accepts_nested_attributes_for :pedidos, reject_if: :all_blank, allow_destroy: true

  
end
