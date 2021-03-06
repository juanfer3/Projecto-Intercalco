class Factura < ApplicationRecord


  has_many :contenedores_de_ordenes, inverse_of: :factura, dependent: :destroy
  accepts_nested_attributes_for :contenedores_de_ordenes, reject_if: :all_blank, allow_destroy: true

  has_many :contenedor_de_remisiones, inverse_of: :contenedor_de_ordenes, dependent: :destroy
  accepts_nested_attributes_for :contenedor_de_remisiones, reject_if: :all_blank, allow_destroy: true


  #has_many :contenedor_de_remisiones, through: :compromisos_de_entrega
  has_many :compromisos_de_entrega, through: :contenedor_de_remisiones

end
