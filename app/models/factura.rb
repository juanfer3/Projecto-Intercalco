class Factura < ApplicationRecord

  has_many :contenedor_de_remisiones, inverse_of: :factura, dependent: :destroy
  accepts_nested_attributes_for :contenedor_de_remisiones, reject_if: :all_blank, allow_destroy: true


  #has_many :contenedor_de_remisiones, through: :compromisos_de_entrega
  has_many :compromisos_de_entrega, through: :contenedor_de_remisiones
end
