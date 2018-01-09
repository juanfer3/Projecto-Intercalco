class Contacto < ApplicationRecord
  belongs_to :cliente
  belongs_to :user
end
