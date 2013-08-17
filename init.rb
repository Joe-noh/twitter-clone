ENV['RACK_ENV'] ||= 'development'

enable :session

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

Dir.glob("#{__dir__}/{config,models}/*.rb").each do |file|
  require file
end
