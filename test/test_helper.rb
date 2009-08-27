ENV["RAILS_ENV"] = "test"

# Load Rails
back_steps = [ '..' ] * %w( test delayed_job_admin plugins vendor ).size
require File.expand_path(File.join(File.dirname(__FILE__), back_steps, 'config', 'environment'))

require 'test_help'
 
gem 'thoughtbot-shoulda' 
require 'shoulda'