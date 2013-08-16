
Sequel::Model.plugin :schema

env = ENV['RACK_ENV']
if env == 'test'
  Sequel.sqlite  # in-memory
else
  Sequel.sqlite("db/#{env}.db")
end
