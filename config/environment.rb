# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Formato fecha
Date::DATE_FORMATS[:default] = "%d/%m/%Y"

#pagination with ajax
