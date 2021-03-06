class TiemposDeEntrega < ApplicationRecord
  belongs_to :pedido

  has_many :facturas_despacho, inverse_of: :tiempos_de_entrega, dependent: :destroy
  accepts_nested_attributes_for :facturas_despacho, reject_if: :all_blank, allow_destroy: true

  def facturas_form
    collection = facturas_despacho.where(pedido_id: id)
    collection.any? ? collection : facturas_despacho.build
  end

end
