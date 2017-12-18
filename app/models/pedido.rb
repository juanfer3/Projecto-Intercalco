class Pedido < ApplicationRecord
  belongs_to :user
  belongs_to :contacto

  belongs_to :linea_de_impresion

  has_many :tiempos_de_entregas, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :tiempos_de_entregas, reject_if: :all_blank, allow_destroy: true

  has_many :despachos, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :despachos, reject_if: :all_blank, allow_destroy: true

  has_many :ordenes_de_produccion, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :ordenes_de_produccion, reject_if: :all_blank, allow_destroy: true

#reject_if: lambda {|attributes| attributes['numero_de_factura'].blank?}


end
