class ContenedorDeOrdenes < ApplicationRecord
  belongs_to :factura
  belongs_to :orden_produccion

  has_many :contenedor_de_remisiones, inverse_of: :contenedor_de_ordenes, dependent: :destroy
  accepts_nested_attributes_for :contenedor_de_remisiones, reject_if: :all_blank, allow_destroy: true


  #has_many :contenedor_de_remisiones, through: :compromisos_de_entrega
  has_many :compromisos_de_entrega, through: :contenedor_de_remisiones

end
