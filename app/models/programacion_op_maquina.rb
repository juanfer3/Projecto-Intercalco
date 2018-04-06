class ProgramacionOpMaquina < ApplicationRecord
  belongs_to :orden_produccion
  belongs_to :maquina
end
