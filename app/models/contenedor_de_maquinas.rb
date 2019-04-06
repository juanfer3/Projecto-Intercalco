class ContenedorDeMaquinas < ApplicationRecord
  belongs_to :montaje
  belongs_to :maquina

  has_many :procesos_maquinas, inverse_of: :contenedor_de_maquinas, dependent: :destroy
  accepts_nested_attributes_for :procesos_maquinas, reject_if: :all_blank, allow_destroy: true

end
