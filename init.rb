ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

enable :sessions

use Warden::Manager do |manager|
  manager.default_strategies :custom_auth_strategy
  manager.failure_app = Sinatra::Application
end

Dir.glob("#{__dir__}/{config,models,helpers}/*.rb").each do |file|
  require file
end

require_relative './app'