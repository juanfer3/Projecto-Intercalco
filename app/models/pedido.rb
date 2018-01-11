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


  validates :numero_cotizacion, presence: true
  validates :cantidad_total, presence: true, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 999999}
  validates :precio_total, presence: true, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 9999999}


end
