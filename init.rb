ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

enable :sessions

Dir.glob("#{__dir__}/{config,models}/*.rb").each do |file|
  require file
end
