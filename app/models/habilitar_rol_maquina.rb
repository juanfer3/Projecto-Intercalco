class HabilitarRolMaquina < ApplicationRecord
  belongs_to :maquina
  belongs_to :rol
end
