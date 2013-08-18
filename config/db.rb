
Sequel::Model.plugin :schema
Sequel::Model.plugin :validation_helpers

Sequel::Model.raise_on_typecast_failure = false

env = ENV['RACK_ENV']
if env == 'test'
  Sequel.sqlite  # in-memory
else
  Sequel.sqlite("db/#{env}.db")
end
