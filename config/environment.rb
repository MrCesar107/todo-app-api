# Load the Rails application.
require_relative "application"
env_variables = File.join(Rails.root.to_s, 'config', 'env_variables.rb')
load(env_variables) if File.exists?(env_variables)

# Initialize the Rails application.
Rails.application.initialize!
