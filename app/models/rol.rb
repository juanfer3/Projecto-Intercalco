class Rol < ApplicationRecord
    
    has_many :users, :through => :assignments
    
end
