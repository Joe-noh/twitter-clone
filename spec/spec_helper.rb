ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require :default, :test

require 'rack/test'

require_relative '../models/require'
require_relative './fabricators'
require_relative '../app'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
end
