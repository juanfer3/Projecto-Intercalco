class Pedido < ApplicationRecord
  belongs_to :contacto

  belongs_to :linea_de_impresion
  
  has_many :tiempos_de_entregas, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :tiempos_de_entregas, reject_if: :all_blank, allow_destroy: true

  has_many :despachos, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :despachos, reject_if: :all_blank, allow_destroy: true
  
  
  
end
