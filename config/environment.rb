# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Formato fecha
Date::DATE_FORMATS[:default] = "%d/%m/%Y"
#Set default date format
#Date::DATE_FORMATS.merge!(:default => "%d/%m/%y")
#pagination with ajax
