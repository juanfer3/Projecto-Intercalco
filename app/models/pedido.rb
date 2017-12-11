class Pedido < ApplicationRecord
  belongs_to :contacto

  belongs_to :linea_de_impresion

  has_many :tiempos_de_entregas, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :tiempos_de_entregas, reject_if: :all_blank, allow_destroy: true

  has_many :despachos, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :despachos, reject_if: lambda {|attributes| attributes['lugar_de_despacho'].blank?}, allow_destroy: true

  has_many :ordenes_de_produccion, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :ordenes_de_produccion, reject_if: :all_blank, allow_destroy: true

  has_many :facturas_despacho, inverse_of: :pedido, dependent: :destroy
  accepts_nested_attributes_for :facturas_despacho, reject_if: :all_blank, allow_destroy: true



end
