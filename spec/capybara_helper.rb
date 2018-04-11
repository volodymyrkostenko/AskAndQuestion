require 'rails_helper'
require 'capybara/rspec'

# specify js driver
Capybara.javascript_driver = :selenium

# for testing ActionCable with Capybara we need a multithreaded webserver
Capybara.server = :puma