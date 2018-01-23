class OrdenProduccion < ApplicationRecord
  belongs_to :formato_op
  belongs_to :mes

  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true


end
