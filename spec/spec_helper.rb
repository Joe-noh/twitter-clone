ENV['RACK_ENV'] = 'test'

require 'rack/test'

require_relative '../init'
require_relative './fabricators'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Warden::Test::Helpers

  conf.after do
    Warden.test_reset!
  end
end

def app
  Sinatra::Application
end
