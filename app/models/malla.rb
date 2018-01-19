class Malla < ApplicationRecord
  has_many :tintas_fop_tiro, inverse_of: :malla, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_tiro, reject_if: :all_blank, allow_destroy: true

  has_many :tintas_fop_retiro, inverse_of: :malla, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_retiro, reject_if: :all_blank, allow_destroy: true

end
