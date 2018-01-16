class OrdenProduccion < ApplicationRecord
  belongs_to :formato_op
  belongs_to :mes
end
