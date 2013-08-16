ENV['RACK_ENV'] = 'test'

require File.expand_path('../app.rb', File.dirname(__FILE__))

require 'rspec'
require 'rack/test'

set :environment, :test

Rspec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
end