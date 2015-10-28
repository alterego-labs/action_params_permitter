$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'action_params_permitter'

require 'rspec/its'

require 'pry-nav'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|file| require file }

RSpec.configure do |config|
  config.order = :random
  #config.filter_run :focus
end
