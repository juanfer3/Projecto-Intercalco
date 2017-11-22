class Cliente < ApplicationRecord
  
  belongs_to :user
  has_many :contactos , inverse_of: :cliente, dependent: :destroy
  accepts_nested_attributes_for :contactos, reject_if: :all_blank, allow_destroy: true
  
end
