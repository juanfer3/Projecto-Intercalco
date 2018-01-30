class Transicion < ApplicationRecord
  belongs_to :desarrollo_de_tinta
  belongs_to :tinta_formulada
end
