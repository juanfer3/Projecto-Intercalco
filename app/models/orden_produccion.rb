class OrdenProduccion < ApplicationRecord
  belongs_to :montaje

  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true

  has_many :formulas_tinta, inverse_of: :tinta_formulada, dependent: :destroy
  accepts_nested_attributes_for :formulas_tinta, reject_if: :all_blank, allow_destroy: true

  has_many :transiciones, inverse_of: :tinta_formulada, dependent: :destroy
  accepts_nested_attributes_for :transiciones, reject_if: :all_blank, allow_destroy: true

end
