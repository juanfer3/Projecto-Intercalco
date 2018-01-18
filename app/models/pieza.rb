class Pieza < ApplicationRecord
  belongs_to :montaje, dependent: :destroy
end
