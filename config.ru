require 'bundler/setup'

Bundler.require(:default)
Bundler.require(:development) if development?

require './app.rb'

run Sinatra::Application